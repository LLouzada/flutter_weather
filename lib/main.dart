import 'package:flutter/material.dart';
import 'package:flutter_weather/app/util/dependency_injector.dart';
import 'package:flutter_weather/presentation/app.dart';
import 'package:get/get.dart';

import 'presentation/controllers/startup/startup_controller.dart';

// todo - GPS + tela de permissão
// todo - principal
// todo - onboarding (simples)
// todo - tema (dark/light) ?
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjector.init();
  await Get.find<StartupController>().determineInitialRoute();

  runApp(const App());
}
