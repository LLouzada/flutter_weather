import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather/app/config/app_constants.dart';
import 'package:flutter_weather/app/services/local_storage.dart';
import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:get/get.dart';
import 'package:json_theme_plus/json_theme_plus.dart';

class ThemeController extends GetxController with AppLogger {
  var isDarkMode = false.obs;
  LocalStorageService? _storage;

  @override
  void onInit() {
    super.onInit();
    _storage = Get.find<LocalStorageService>();
    logd('Storage is null: ${_storage == null}');

    // Verifica se o usuário já selecionou um tema
    final theme = _storage!.getBool(AppConstants.storeKeyIsDarkTheme);
    logd('isDarkTheme: $theme');
    if (theme != null) {
      isDarkMode.value = theme;
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
      return;
    }

    // Detectar o tema do sistema ao inicializar
    final brightness = PlatformDispatcher.instance.platformBrightness;
    isDarkMode.value = brightness == Brightness.dark;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Método para alternar entre os temas manualmente
  void toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    logd('toggling theme: $isDarkMode, storage is null: ${_storage == null}');
    await _storage!.setBool(AppConstants.storeKeyIsDarkTheme, isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<ThemeData> buildLightTheme() async {
    final lightThemeStr =
        await rootBundle.loadString('assets/jsons/app_theme_light.json');
    final lightThemeJson = jsonDecode(lightThemeStr);
    return ThemeDecoder.decodeThemeData(lightThemeJson)!;
  }

  Future<ThemeData> buildDarkTheme() async {
    final darkThemeStr =
        await rootBundle.loadString('assets/jsons/app_theme_dark.json');
    final darkThemeJson = jsonDecode(darkThemeStr);
    return ThemeDecoder.decodeThemeData(darkThemeJson)!;
  }
}
