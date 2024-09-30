import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_weather/app/services/local_storage.dart';
import 'package:flutter_weather/app/util/dependency_injector.dart';
import 'package:flutter_weather/presentation/app.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';

import 'presentation/controllers/boot_controller.dart';

// todo - GPS + tela de permissão
// todo - principal
// todo - onboarding (simples)
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Aguarda a inicialização do DependencyInjector
  await DependencyInjector.boot();

  bool hasBooted = await Get.find<BootController>().boot();
  if (!hasBooted) {
    throw Exception('Erro ao iniciar o app');
  }

  // Inicia o ThemeController para carregar os temas
  final ThemeController themeController = Get.find<ThemeController>();
  final ThemeData lightTheme = await themeController.buildLightTheme();
  final ThemeData darkTheme = await themeController.buildDarkTheme();

  runApp(App(lightTheme: lightTheme, darkTheme: darkTheme));
}
