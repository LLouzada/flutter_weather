import 'package:flutter_weather/data/repositories/city_repository_impl.dart';
import 'package:flutter_weather/data/repositories/location_repository_impl.dart';
import 'package:flutter_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_weather/domain/repositories/city_repository.dart';
import 'package:flutter_weather/domain/repositories/location_repository.dart';
import 'package:flutter_weather/domain/repositories/weather_repository.dart';
import 'package:flutter_weather/domain/usecases/fetch_city_use_case.dart';
import 'package:flutter_weather/domain/usecases/fetch_location_use_case.dart';
import 'package:flutter_weather/domain/usecases/fetch_weather_use_case.dart';
import 'package:flutter_weather/presentation/controllers/onboarding_controller.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:get/get.dart';

/// Binds the dependencies for the initial setup of the application.
///
/// These dependencies are set up using the GetX dependency injection system,
/// which allows for lazy initialization and automatic resolution of dependencies.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Onboarding Dependencies
    Get.lazyPut<OnboardingController>(() => OnboardingController());

    // Repositories
    Get.lazyPut<LocationRepository>(() => LocationRepositoryImpl());
    Get.lazyPut<CityRepository>(() => CityRepositoryImpl());
    Get.lazyPut<WeatherRepository>(() => WeatherRepositoryImpl());

    // Use Cases
    Get.lazyPut<FetchLocationUseCase>(
        () => FetchLocationUseCase(Get.find<LocationRepository>()));
    Get.lazyPut<FetchCityUseCase>(
        () => FetchCityUseCase(Get.find<CityRepository>()));
    Get.lazyPut<FetchWeatherUseCase>(
        () => FetchWeatherUseCase(Get.find<WeatherRepository>()));

    // Controllers
    Get.lazyPut<WeatherController>(() => WeatherController(
        Get.find<FetchLocationUseCase>(),
        Get.find<FetchCityUseCase>(),
        Get.find<FetchWeatherUseCase>()));
  }
}
