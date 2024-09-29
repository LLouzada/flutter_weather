import 'package:flutter_weather/presentation/controllers/startup/startup_controller.dart';
import 'package:get/get.dart';

/// Add controllers to the Getx dependency injection system.
/// This way, they can be accessed from anywhere in the app.
class StartupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartupController>(() => StartupController(), fenix: true);
  }
}
