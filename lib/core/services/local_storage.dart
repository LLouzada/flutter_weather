import 'package:flutter_weather/core/utils/app_logger.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends GetxService with AppLogger {
  SharedPreferences? _sharedPreferences;

  Future<bool> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences!.setString(key, value);
  }

  String? getString(String key) {
    return _sharedPreferences!.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences!.setBool(key, value);
  }

  bool? getBool(String key) {
    logD('shared prefs is null: ${_sharedPreferences == null}');
    return _sharedPreferences?.getBool(key);
  }
}
