import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:json_theme_plus/json_theme_plus.dart';

class ThemeController extends GetxController {
  // Observable que armazena o estado do tema
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Detectar o tema do sistema ao inicializar
    final brightness = PlatformDispatcher.instance.platformBrightness;
    isDarkMode.value = brightness == Brightness.dark;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Método para alternar entre os temas manualmente
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
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
