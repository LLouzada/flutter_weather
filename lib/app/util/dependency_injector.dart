import 'package:flutter_weather/app/services/local_storage.dart';
import 'package:flutter_weather/presentation/controllers/boot/boot_controller.dart';
import 'package:flutter_weather/presentation/controllers/theme/theme_controller.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static boot() {
    Get.put(BootController());
    Get.put(ThemeController());
    Get.put(LocalStorageService());
  }
}
