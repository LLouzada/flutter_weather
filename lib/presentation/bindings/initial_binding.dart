import 'package:flutter_weather/data/repositories/location_repository.dart';
import 'package:flutter_weather/domain/repositories/location_repository.dart';
import 'package:flutter_weather/domain/usecases/fetch_location_use_case.dart';
import 'package:flutter_weather/presentation/controllers/location_controller.dart';
import 'package:flutter_weather/presentation/controllers/onboarding_controller.dart';
import 'package:get/get.dart';

/// Add controllers to the Getx dependency injection system.
/// This way, they can be accessed from anywhere in the app.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Onboarding Dependencies
    Get.lazyPut<OnboardingController>(() => OnboardingController(),
        fenix: true);

    // Location Dependencies
    Get.lazyPut<LocationRepository>(() => LocationRepositoryImpl());
    Get.lazyPut<FetchLocationUseCase>(
        () => FetchLocationUseCase(Get.find<LocationRepository>()));
    Get.lazyPut<LocationController>(
        () => LocationController(Get.find<FetchLocationUseCase>()));
  }
}
