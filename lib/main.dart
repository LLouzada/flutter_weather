import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_weather/app/services/local_storage.dart';
import 'package:flutter_weather/app/util/dependency_injector.dart';
import 'package:flutter_weather/presentation/app.dart';
import 'package:flutter_weather/presentation/controllers/theme/theme_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:json_theme_plus/json_theme_plus.dart';

import 'presentation/controllers/boot/boot_controller.dart';

// todo - GPS + tela de permissão
// todo - principal
// todo - onboarding (simples)
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  DependencyInjector.boot();
  bool hasBooted = await Get.find<BootController>().boot();
  if (!hasBooted) {
    throw Exception('Erro ao iniciar o app');
  }

  final ThemeController themeController = Get.find<ThemeController>();
  final ThemeData lightTheme = await themeController.buildLightTheme();
  final ThemeData darkTheme = await themeController.buildDarkTheme();

  await Get.putAsync(() => LocalStorageService().init());

  runApp(App(lightTheme: lightTheme, darkTheme: darkTheme));
}
