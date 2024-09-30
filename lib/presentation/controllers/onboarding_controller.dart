import 'package:flutter_weather/app/config/app_constants.dart';
import 'package:flutter_weather/app/config/app_routes.dart';
import 'package:flutter_weather/app/services/local_storage.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final store = Get.find<LocalStorageService>();

  void onFinish() async {
    await store.setBool(AppConstants.storeKeyOnboarding, true);
    Get.offAllNamed(AppRoutes.home.path);
  }
}
