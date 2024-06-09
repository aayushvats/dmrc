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

  Future<String?> getStationInfo(String stationCode) async {
    final db = await database; // Assuming 'database' is your database instance

    // Define the SQL query
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

    // Execute the query
    final List<Map<String, dynamic>> result = await db.rawQuery(
        sqlQuery, [stationCode]);

    if (result.isNotEmpty) {
      // Print the result
      print("---------Station Information------");
      print(result.first);

      return "";
    } else {
      return null;
    }
  }
  // Function to fetch and print line details
  Future<void> getLineDetails(String lineCode) async {
    final db = await database; // Assuming 'database' is your database instance

    // Define the SQL query
    final String sqlQuery = "SELECT * FROM MetroLines WHERE code = ?";

    // Execute the query
    final List<Map<String, dynamic>> result = await db.rawQuery(sqlQuery, [lineCode]);

    // Print the line details
    print("---------Line Details------");
    print(result);
  }
  Future<void> getNearestStation(double latitude, double longitude) async {
    final db = await database; // Assuming 'database' is your database instance

    // Define the SQL query
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

    // Execute the query
    final List<Map<String, dynamic>> result = await db.rawQuery(
        sqlQuery, [latitude, longitude]);

    // Print the nearest station details
    print("---------Nearest Station------");
    print(result);

  }
}