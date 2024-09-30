import 'package:flutter/material.dart';
import 'package:flutter_weather/app/config/app_routes.dart';
import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController with AppLogger {
  void handlePermission() async {
    await Permission.location.onDeniedCallback(() {
      Get.snackbar(
        'Permissão Negada',
        'permita o acesso à sua localização para obter previsões de clima mais precisas.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(Get.context!).colorScheme.secondary,
        colorText: Theme.of(Get.context!).colorScheme.onSecondary,
      );
    }).onGrantedCallback(() {
      logd('Permission granted');
      Get.toNamed(AppRoutes.home.path);
    }).onPermanentlyDeniedCallback(() {
      logd('permanently denied');
      Get.toNamed(AppRoutes.home.path);
    }).onRestrictedCallback(() {
      logd('Permission restricted');
    }).onLimitedCallback(() {
      logd('Permission limited');
    }).onProvisionalCallback(() {
      logd('Permission provisional');
    }).request();
  }
}
