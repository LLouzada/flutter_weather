import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_weather/app/config/app_constants.dart';
import 'package:flutter_weather/app/config/app_pages.dart';
import 'package:flutter_weather/presentation/bindings/startup_binding.dart';
import 'package:flutter_weather/presentation/pages/home/home_page.dart';
import 'package:get/get_navigation/src/root/get_cupertino_app.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? GetMaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            initialBinding: StartupBinding(),
            initialRoute: '/',
            getPages: AppPages.pages,
            home: const HomePage(),
          )
        : GetCupertinoApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            initialBinding: StartupBinding(),
            getPages: AppPages.pages,
            home: const HomePage(),
          );
  }
}
