import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_weather/core/utils/dependency_injector.dart';
import 'package:flutter_weather/presentation/app.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_weather/presentation/controllers/boot_controller.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserves the splash screen until the app is ready to be shown
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Awaits the boot dependencies to be initialized
  await DependencyInjector.boot();

  // Initializes the boot controller
  bool hasBooted = await Get.find<BootController>().boot();
  if (!hasBooted) {
    throw Exception('Erro ao iniciar o app');
  }

  // Initializes and builds the themes
  final ThemeController themeController = Get.find<ThemeController>();
  final ThemeData lightTheme = await themeController.buildLightTheme();
  final ThemeData darkTheme = await themeController.buildDarkTheme();

  // Removes the splash screen after the app is ready to be shown
  FlutterNativeSplash.remove();

  runApp(App(lightTheme: lightTheme, darkTheme: darkTheme));
}
