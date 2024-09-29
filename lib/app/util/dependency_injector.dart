import 'package:flutter_weather/presentation/controllers/startup/startup_controller.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static init() {
    Get.put(StartupController());
  }
}
