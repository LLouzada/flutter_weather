import 'package:flutter/material.dart';
import 'package:flutter_weather/app/config/app_routes.dart';
import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController with AppLogger {
  Future<bool> hasLocationPermission() async {
    return await Permission.location.status.isGranted;
  }

  void handleLocastionPermission() async {
    await Permission.location.onDeniedCallback(() {
      logd('Permission denied');
      _showlocationPermissionSnackBar();
    }).onGrantedCallback(() {
      logd('Permission granted');
      Get.offAllNamed(AppRoutes.home.path);
    }).onPermanentlyDeniedCallback(() {
      logd('permanently denied');
      Get.offAllNamed(AppRoutes.permission.path);
    }).onRestrictedCallback(() {
      logd('Permission restricted');
    }).onLimitedCallback(() {
      logd('Permission limited');
    }).onProvisionalCallback(() {
      logd('Permission provisional');
    }).request();
  }

  _showlocationPermissionSnackBar() {
    Get.snackbar(
      'Permissão Negada',
      'Permita o acesso à sua localização para obter previsões de clima mais precisas.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Theme.of(Get.context!).colorScheme.secondary,
      colorText: Theme.of(Get.context!).colorScheme.onSecondary,
    );
  }
}
