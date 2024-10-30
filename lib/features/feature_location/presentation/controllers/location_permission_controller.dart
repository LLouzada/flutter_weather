import 'package:flutter/material.dart';
import 'package:flutter_weather/core/config/app_routes.dart';
import 'package:flutter_weather/core/utils/app_logger.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionController extends GetxController with AppLogger {
  Future<bool> hasLocationServiceEnabled() async {
    return await Permission.location.serviceStatus.isEnabled;
  }

  Future<bool> hasLocationPermission() async {
    return await Permission.location.status.isGranted;
  }

  void handleLocastionPermission() async {
    if (!(await hasLocationServiceEnabled())) {
      _showlocationPermissionSnackBar(
          title: 'O serviço de localização está desativado.',
          message: 'Por favor, ative o serviço de localização para continuar.');

      return;
    }

    await Permission.location.onDeniedCallback(() {
      logD('Permission denied');
      _showlocationPermissionSnackBar();
    }).onGrantedCallback(() {
      logD('Permission granted');
      Get.offAllNamed(AppRoutes.home.path);
      return;
    }).onPermanentlyDeniedCallback(() {
      logD('permanently denied');
    }).onRestrictedCallback(() {
      logD('Permission restricted');
    }).onLimitedCallback(() {
      logD('Permission limited');
    }).onProvisionalCallback(() {
      logD('Permission provisional');
    }).request();

    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.home.path);
  }

  _showlocationPermissionSnackBar({String? title, String? message}) {
    Get.snackbar(
        title ?? 'Permissão de localização negada',
        message ??
            'Considere permitir acesso à localização ou ativar os serviços de localização para uma experiência mais completa.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(Get.context!).colorScheme.secondary,
        colorText: Theme.of(Get.context!).colorScheme.onSecondary,
        icon: Icon(
          Icons.location_on_outlined,
          color: Theme.of(Get.context!).colorScheme.onSecondary,
        ));
  }
}
