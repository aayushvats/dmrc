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

  Future<String?> getStationID(String stationName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'StationDetails',
      columns: ['station_name'],
      where: 'station_code = ?',
      whereArgs: [stationName],
    );
    final List<Map<String, dynamic>> maps2 = await db.rawQuery("select * from StationDetails where station_code='AZU';");
    print("---------in here------");
    print(maps);
    if (maps.isNotEmpty) {
      return maps.first['station_name'] as String?;
    } else {
      return null;
    }
  }
}