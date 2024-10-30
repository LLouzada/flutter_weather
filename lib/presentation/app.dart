import 'package:flutter/material.dart';
import 'package:flutter_weather/core/config/app_constants.dart';
import 'package:flutter_weather/core/config/app_pages.dart';
import 'package:flutter_weather/core/bindings/initial_binding.dart';
import 'package:flutter_weather/presentation/controllers/boot_controller.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';

/// The main app class
class App extends StatelessWidget {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  const App({super.key, required this.lightTheme, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode:
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      initialBinding: InitialBinding(),
      initialRoute: Get.find<BootController>().getInitialRoute,
      getPages: AppPages.pages,
    );
  }
}
