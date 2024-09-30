import 'package:flutter_weather/presentation/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter_weather/presentation/controllers/permission/permission_controller.dart';
import 'package:get/get.dart';

/// Add controllers to the Getx dependency injection system.
/// This way, they can be accessed from anywhere in the app.
class BootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController(),
        fenix: true);
    Get.lazyPut<PermissionController>(() => PermissionController(),
        fenix: true);
  }
}
