import 'package:flutter_weather/app/config/app_routes.dart';
import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:get/get.dart';

class BootController extends GetxController with AppLogger {
  var isAppInitialized = false.obs;
  final _initialRoute = ''.obs;

  Future<bool> boot() async {
    logd('booting app');
    await _determineInitialRoute();
    isAppInitialized.value = true;
    return true;
  }

  /// initiaRoute getter
  String get getInitialRoute => _initialRoute.value;

  Future<void> _determineInitialRoute() async {
    logd('determining initial route');
    bool hasSeenOnboarding = await _checkOnboardingStatus();

    bool hasLocationPermission = await _checkLocationPermission();

    logd(
        'hasLocationPermission: $hasLocationPermission, hasSeenOnboarding: $hasSeenOnboarding');

    if (!hasSeenOnboarding) {
      logd('initial route: onboarding');
      _initialRoute.value = AppRoutes.onboarding.path;
      return;
    }

    if (!hasLocationPermission) {
      logd('initial route: permission');
      _initialRoute.value = AppRoutes.permission.path;
      return;
    }

    logd('initial route: home');
    _initialRoute.value = AppRoutes.home.path;
  }

  // Função para verificar o status do onboarding
  Future<bool> _checkOnboardingStatus() async {
    //todo - usar o meu service para pegar o shared preferences
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getBool('hasSeenOnboarding') ?? false;
    await Future.delayed(const Duration(seconds: 2));
    return false;
  }

  // Função para verificar permissão de localização
  Future<bool> _checkLocationPermission() async {
    // PermissionStatus status = await Permission.location.status;
    // return status.isGranted;
    await Future.delayed(const Duration(seconds: 2));
    return false;
  }
}
