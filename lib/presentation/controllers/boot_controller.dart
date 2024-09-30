import 'package:flutter_weather/app/config/app_constants.dart';
import 'package:flutter_weather/app/config/app_routes.dart';
import 'package:flutter_weather/app/services/local_storage.dart';
import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:flutter_weather/presentation/controllers/permission_controller.dart';
import 'package:get/get.dart';

class BootController extends GetxController with AppLogger {
  var isAppInitialized = false.obs;
  final _initialRoute = ''.obs;
  LocalStorageService? _storage;

  Future<bool> boot() async {
    logd('booting app');
    _storage = Get.find<LocalStorageService>();
    await _determineInitialRoute();
    isAppInitialized.value = true;
    return true;
  }

  /// initiaRoute getter
  String get getInitialRoute => _initialRoute.value;

  Future<void> _determineInitialRoute() async {
    logd('determining initial route');
    bool hasSeenOnboarding = await _checkOnboardingStatus();

    if (!hasSeenOnboarding) {
      logd('initial route: onboarding');
      _initialRoute.value = AppRoutes.onboarding.path;
      return;
    }

    bool hasLocationPermission = await _checkLocationPermission();

    if (!hasLocationPermission) {
      logd('initial route: permission');
      _initialRoute.value = AppRoutes.permission.path;
      return;
    }

    logd('initial route: home');
    _initialRoute.value = AppRoutes.home.path;
  }

  // Metodo private para verificar se o usuário já viu o onboarding
  Future<bool> _checkOnboardingStatus() async {
    final bool? hasSeenOnboarding =
        _storage!.getBool(AppConstants.storeKeyOnboarding);
    logd('hasSeenOnboarding: $hasSeenOnboarding');
    return hasSeenOnboarding ?? false;
  }

  // Função para verificar permissão de localização
  Future<bool> _checkLocationPermission() async {
    final bool hasLocationPermission =
        await Get.find<PermissionController>().hasLocationPermission();
    logd('hasLocationPermission: $hasLocationPermission');
    return hasLocationPermission;
  }
}
