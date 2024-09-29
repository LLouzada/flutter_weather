import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class StartupController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _determineInitialRoute();
  }

  Future<void> _determineInitialRoute() async {
    bool hasSeenOnboarding = await _checkOnboardingStatus();

    bool hasLocationPermission = await _checkLocationPermission();

    if (!hasSeenOnboarding) {
      Get.offAllNamed('/onboarding');
    } else if (!hasLocationPermission) {
      Get.offAllNamed('/permission');
    } else {
      Get.offAllNamed('/home');
    }
  }

  // Função para verificar o status do onboarding
  Future<bool> _checkOnboardingStatus() async {
    //todo - usar o meu service para pegar o shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasSeenOnboarding') ?? false;
  }

  // Função para verificar permissão de localização
  Future<bool> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    return status.isGranted;
  }
}
