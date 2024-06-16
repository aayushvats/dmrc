import 'package:dmrc/models/stationDetails.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "dmrc_data.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // If the database doesn't exist, copy it from the assets
      ByteData data = await rootBundle.load('assets/db/dmrc_data.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write the bytes to the file
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path);
  }

  Future<StationDetails> getStationInfo(String stationCode) async {
    StationDetails station;
    final db = await database;
    final String sqlQuery = '''
  WITH Params AS (
      SELECT ? AS stationCode -- Placeholder for station code
  ),
  StationInfo AS (
      SELECT 
          sd.station_code AS stationID,
          sd.station_name AS name,
          CASE WHEN COUNT(ls.lineCode) > 1 THEN 'true' ELSE 'false' END AS isInterchange,
          GROUP_CONCAT(ls.lineCode) AS lines
      FROM 
          LineStations ls
      JOIN 
          StationDetails sd ON ls.stationCode = sd.station_code
      WHERE 
          sd.station_code = (SELECT stationCode FROM Params)
      GROUP BY 
          sd.station_code, sd.station_name
  ),
  LineInfo AS (
      SELECT 
          ls.lineCode,
          ls.stationCode,
          ls.seq
      FROM 
          LineStations ls
      JOIN 
          StationDetails sd ON ls.stationCode = sd.station_code
      WHERE 
          ls.stationCode = (SELECT stationCode FROM Params)
  ),
  AdjacentStations AS (
      SELECT 
          li.lineCode,
          li.stationCode AS currentStationCode,
          prev.stationCode AS prevStationCode,
          next.stationCode AS nextStationCode
      FROM 
          LineStations li
      LEFT JOIN 
          LineStations prev ON li.lineCode = prev.lineCode AND li.seq = prev.seq + 1
      LEFT JOIN 
          LineStations next ON li.lineCode = next.lineCode AND li.seq = next.seq - 1
      WHERE 
          li.stationCode = (SELECT stationCode FROM Params)
  ),
  StationGroups AS (
      SELECT
          lineCode,
          GROUP_CONCAT(prevStationCode) AS prevStations,
          GROUP_CONCAT(nextStationCode) AS nextStations
      FROM
          AdjacentStations
      GROUP BY
          lineCode
  )
  SELECT
      si.stationID,
      si.name,
      si.isInterchange,
      si.lines,
      (SELECT prevStations || ',' || nextStations FROM StationGroups WHERE lineCode = (SELECT lineCode FROM LineInfo LIMIT 1 OFFSET 0)) AS stations1,
      (SELECT prevStations || ',' || nextStations FROM StationGroups WHERE lineCode = (SELECT lineCode FROM LineInfo LIMIT 1 OFFSET 1)) AS stations2,
      (SELECT prevStations || ',' || nextStations FROM StationGroups WHERE lineCode = (SELECT lineCode FROM LineInfo LIMIT 1 OFFSET 2)) AS stations3
  FROM
      StationInfo si;
  ''';
    final List<Map<String, dynamic>> result =
        await db.rawQuery(sqlQuery, [stationCode]);
    print(result);
    if (result.isNotEmpty) {
      station = StationDetails(
        stationID: stationCode,
        name: result[0]['name'],
        isInterchange: result[0]['isInterchange']=='true'?true:false,
        lines: result[0]['lines'].split(","),
        stations1: result[0]['stations1']==null?null:result[0]['stations1'].split(","),
        stations2: result[0]['stations2']==null?null:result[0]['stations2'].split(","),
        stations3: result[0]['stations3']==null?null:result[0]['stations3'].split(",")
      );
      return station;
    } else {
      return StationDetails(
        stationID: "AZU",
        name: 'SAMPLE STATION',
        isInterchange: true,
        lines: ['yellow', 'pink'],
        stations1: ['ADN', 'MDT'],
        stations2: ['MJP', 'SHB'],
      );
      ;
    }
  }

  Future<dynamic> getLineDetails(String lineCode) async {
    final db = await database;
    final String sqlQuery = "SELECT * FROM MetroLines WHERE code = ?";
    final List<Map<String, dynamic>> result =
        await db.rawQuery(sqlQuery, [lineCode]);
    return result;
  }

  Future<StationDetails> getNearestStation(
      double latitude, double longitude) async {
    StationDetails station;
    final db = await database;
    final String sqlQuery = '''
  WITH params AS (
      SELECT ? AS target_lat, ? AS target_lon
  )
  SELECT station_code AS stationID, station_name AS name, latitude, longitude,
         ((latitude - target_lat) * (latitude - target_lat) + (longitude - target_lon) * (longitude - target_lon)) AS distance
  FROM StationDetails, params
  ORDER BY distance
  LIMIT 1;
  ''';
    final List<Map<String, dynamic>> result =
        await db.rawQuery(sqlQuery, [latitude, longitude]);
    station = await getStationInfo(result[0]['stationID']);
    return station;
  }
}
