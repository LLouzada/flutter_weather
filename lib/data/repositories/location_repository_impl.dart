import 'package:flutter/material.dart';
import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:flutter_weather/data/models/location_model.dart';
import 'package:flutter_weather/domain/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationRepositoryImpl with AppLogger implements LocationRepository {
  @override
  Future<LocationModel> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      logE('Location services are disabled.');
      _locationExceptionSnackbar();
      return _locationException();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        logE('Location permission denied.');
        _locationExceptionSnackbar();
        return _locationException();
      }
    }

    Position position = await Geolocator.getCurrentPosition();

    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  LocationModel _locationException() {
    return LocationModel(latitude: -1, longitude: -1);
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
