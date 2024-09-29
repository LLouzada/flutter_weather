import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends GetxService with AppLogger {
  SharedPreferences? _sharedPreferences;

  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences!.setString(key, value);
  }

  String? getString(String key) {
    return _sharedPreferences!.getString(key);
  }
}
