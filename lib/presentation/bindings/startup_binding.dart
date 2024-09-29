// Add controllers to the Getx dependency injection system.
// This way, they can be accessed from anywhere in the app.
import 'package:flutter_weather/presentation/controllers/startup_controller.dart';
import 'package:get/get.dart';

class StartupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartupController());
  }
}
