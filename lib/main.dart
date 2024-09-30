import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_weather/app/util/dependency_injector.dart';
import 'package:flutter_weather/presentation/app.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_weather/presentation/controllers/boot_controller.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserva a splash screen enquanto o app é inicializado
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Aguarda a inicialização do DependencyInjector
  await DependencyInjector.boot();

  // Inicia o BootController para determinar a rota inicial e inicializar o app
  bool hasBooted = await Get.find<BootController>().boot();
  if (!hasBooted) {
    throw Exception('Erro ao iniciar o app');
  }

  // Inicia o ThemeController para carregar os temas
  final ThemeController themeController = Get.find<ThemeController>();
  final ThemeData lightTheme = await themeController.buildLightTheme();
  final ThemeData darkTheme = await themeController.buildDarkTheme();

  // Remove a splash screen
  FlutterNativeSplash.remove();

  runApp(App(lightTheme: lightTheme, darkTheme: darkTheme));
}
