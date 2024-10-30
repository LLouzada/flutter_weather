import 'package:flutter_weather/features/feature_city/data/repositories/city_repository_impl.dart';
import 'package:flutter_weather/features/feature_location/data/repositories/location_repository_impl.dart';
import 'package:flutter_weather/features/feature_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_weather/features/feature_city/domain/repositories/city_repository.dart';
import 'package:flutter_weather/features/feature_location/domain/repositories/location_repository.dart';
import 'package:flutter_weather/features/feature_weather/domain/repositories/weather_repository.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/clear_history_usecase.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/fetch_city_use_case.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/fetch_history_usecase.dart';
import 'package:flutter_weather/features/feature_location/domain/usecases/fetch_location_usecase.dart';
import 'package:flutter_weather/features/feature_weather/domain/usecases/fetch_weather_usecase.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/save_city_usecase.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/search_city_usecase.dart';
import 'package:flutter_weather/features/feature_city/presentation/views/city_controller.dart';
import 'package:flutter_weather/features/feature_onboarding/presentation/controllers/onboarding_controller.dart';
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
    Get.lazyPut<LocationRepository>(() => LocationRepositoryImpl(),
        fenix: true);
    Get.lazyPut<CityRepository>(() => CityRepositoryImpl(), fenix: true);
    Get.lazyPut<WeatherRepository>(() => WeatherRepositoryImpl(), fenix: true);

    // Use Cases
    Get.lazyPut<FetchLocationUseCase>(
        () => FetchLocationUseCase(Get.find<LocationRepository>()),
        fenix: true);
    Get.lazyPut<FetchCityUseCase>(
        () => FetchCityUseCase(Get.find<CityRepository>()),
        fenix: true);
    Get.lazyPut<FetchWeatherUseCase>(
        () => FetchWeatherUseCase(Get.find<WeatherRepository>()),
        fenix: true);
    Get.lazyPut<SearchCityUseCase>(
        () => SearchCityUseCase(Get.find<CityRepository>()),
        fenix: true);
    Get.lazyPut<SaveCityUseCase>(
        () => SaveCityUseCase(Get.find<CityRepository>()),
        fenix: true);
    Get.lazyPut<ClearHistoryUseCase>(
        () => ClearHistoryUseCase(Get.find<CityRepository>()),
        fenix: true);
    Get.lazyPut<FetchHistoryUsecase>(
        () => FetchHistoryUsecase(Get.find<CityRepository>()),
        fenix: true);

    // Controllers
    Get.lazyPut<WeatherController>(
        () => WeatherController(
            Get.find<FetchLocationUseCase>(),
            Get.find<FetchCityUseCase>(),
            Get.find<FetchWeatherUseCase>(),
            Get.find<SaveCityUseCase>()),
        fenix: true);
    Get.lazyPut<CityController>(
        () => CityController(
              Get.find<SearchCityUseCase>(),
              Get.find<ClearHistoryUseCase>(),
              Get.find<FetchHistoryUsecase>(),
            ),
        fenix: true);
  }
}
