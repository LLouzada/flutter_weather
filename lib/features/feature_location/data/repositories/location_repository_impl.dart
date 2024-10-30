import 'package:flutter/material.dart';
import 'package:flutter_weather/core/utils/app_logger.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/features/feature_location/domain/repositories/location_repository.dart';
import 'package:flutter_weather/presentation/controllers/permission_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationRepositoryImpl with AppLogger implements LocationRepository {
  final LocationPermissionController _permissionController =
      Get.find<LocationPermissionController>();
  @override
  Future<LocationModel> getCurrentLocation() async {
    if (!(await _permissionController.hasLocationServiceEnabled())) {
      logE('Location services are disabled.');
      _locationExceptionSnackbar();
      return LocationModel.empty();
    }

    if (!(await _permissionController.hasLocationPermission())) {
      logE('Location permission denied.');
      _locationExceptionSnackbar();
      return LocationModel.empty();
    }

    Position position = await Geolocator.getCurrentPosition();

    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  void _locationExceptionSnackbar() {
    Get.snackbar(
      'Permissão de localização negada ou serviços de localização desativados.',
      'Considere permitir acesso à localização ou ativar os serviços de localização'
          'para uma experiência mais completa.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      backgroundColor: Theme.of(Get.context!).colorScheme.secondary,
      colorText: Theme.of(Get.context!).colorScheme.onSecondary,
    );
  }
}
