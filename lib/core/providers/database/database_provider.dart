import 'package:flutter_weather/core/config/app_constants.dart';
import 'package:flutter_weather/core/utils/app_logger.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_model.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
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
    return await openDatabase(path,
        version: AppConstants.appDbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE city (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      state TEXT NOT NULL,
      country TEXT NOT NULL,
      latitude REAL NOT NULL,
      longitude REAL NOT NULL,
      date TEXT NOT NULL
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

  Future<void> saveCity(CityModel city, LocationModel location) async {
    final db = await database;

    final String cityName = city.name;
    final String cityState = city.state;
    final String cityCountry = city.country;
    final double cityLatitude = location.latitude;
    final double cityLongitude = location.longitude;
    final String date = DateTime.now().toIso8601String();

    try {
      final List<Map<String, dynamic>> existingCity = await db.query(
        'city',
        where: 'name = ?',
        whereArgs: [cityName],
      );

      if (existingCity.isNotEmpty) {
        await db.update(
          'city',
          {'date': date},
          where: 'name = ?',
          whereArgs: [cityName],
        );
      } else {
        await db.transaction((txn) async {
          await txn.rawInsert(
            'INSERT INTO city (name, state, country, latitude, longitude, date) VALUES (?, ?, ?, ?, ?, ?)',
            [
              cityName,
              cityState,
              cityCountry,
              cityLatitude,
              cityLongitude,
              date
            ],
          );
        });
      }
    } catch (e) {
      logE('Erro ao salvar a cidade: $e');
    }
  }

  Future<List<CityModel>> getCities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('city', orderBy: 'date DESC');

    return List.generate(maps.length, (i) {
      return CityModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        state: maps[i]['state'],
        country: maps[i]['country'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
      );
    });
  }

  Future<void> clearHistory() async {
    final db = await database;
    await db.delete('city');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
