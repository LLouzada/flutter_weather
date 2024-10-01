import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider with AppLogger {
  static Database? _database;

  static final DatabaseProvider _singleton = DatabaseProvider._internal();
  factory DatabaseProvider() => _singleton;

  DatabaseProvider._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'weather_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE city (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        state TEXT,
        country TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE weather (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        min_temperature REAL NOT NULL,
        max_temperature REAL NOT NULL,
        precipitation REAL NOT NULL,
        humidity INTEGER,
        weather_code INTEGER,
        FOREIGN KEY (city_id) REFERENCES city(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<int> insertWeatherData(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('weather_history', data);
  }

  Future<List<Map<String, dynamic>>> getWeatherHistory() async {
    final db = await database;
    return await db.query('weather_history');
  }

  Future<int> deleteWeatherData(int id) async {
    final db = await database;
    return await db.delete(
      'weather_history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearWeatherHistory() async {
    final db = await database;
    await db.delete('weather_history');
  }

  Future<List<Map<String, dynamic>>> getWeatherHistoryByCity(int cityId) async {
    final db = await database;
    return await db.query(
      'weather_history',
      where: 'city_id = ?',
      whereArgs: [cityId],
    );
  }

  Future<void> insertCityData(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert('city', data);
  }

  Future<List<Map<String, dynamic>>> getCityData() async {
    final db = await database;
    return await db.query('city');
  }

  Future<void> deleteCityData(int id) async {
    final db = await database;
    await db.delete(
      'city',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getCityDataById(int id) async {
    final db = await database;
    return await db.query(
      'city',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
