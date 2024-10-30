import 'package:flutter_weather/core/config/app_constants.dart';
import 'package:flutter_weather/core/config/app_routes.dart';
import 'package:flutter_weather/core/services/local_storage.dart';
import 'package:flutter_weather/presentation/controllers/permission_controller.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final store = Get.find<LocalStorageService>();

  void onFinish() async {
    await store.setBool(AppConstants.storeKeyOnboarding, true);

    await Get.find<LocationPermissionController>().hasLocationPermission()
        ? Get.offAllNamed(AppRoutes.home.path)
        : Get.offAllNamed(AppRoutes.permission.path);
  }
}
