import 'package:flutter/material.dart';
import 'package:flutter_weather/app/config/app_routes.dart';
import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController with AppLogger {
  Future<bool> hasLocationPermission() async {
    return await Permission.location.status.isGranted;
  }

  Future<bool> hasnotLocationPermissionService() async {
    return await Permission.location.serviceStatus.isEnabled == false;
  }

  void handleLocastionPermission() async {
    if (await (hasnotLocationPermissionService())) {
      Get.snackbar('O serviço de localização está desativado.',
          'Por favor, ative o serviço de localização para continuar.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Theme.of(Get.context!).colorScheme.secondary,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
          icon: Icon(
            Icons.location_on_outlined,
            color: Theme.of(Get.context!).colorScheme.onSecondary,
          ));
      return;
    }

    await Permission.location.onDeniedCallback(() {
      logD('Permission denied');
      _showlocationPermissionSnackBar();
    }).onGrantedCallback(() {
      logD('Permission granted');
      Get.offAllNamed(AppRoutes.home.path);
    }).onPermanentlyDeniedCallback(() {
      logD('permanently denied');
      Get.offAllNamed(AppRoutes.permission.path);
    }).onRestrictedCallback(() {
      logD('Permission restricted');
    }).onLimitedCallback(() {
      logD('Permission limited');
    }).onProvisionalCallback(() {
      logD('Permission provisional');
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
