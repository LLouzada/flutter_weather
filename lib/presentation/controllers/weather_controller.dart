import 'package:flutter_weather/core/config/app_routes.dart';
import 'package:flutter_weather/core/core/usecases/save_city_params.dart';
import 'package:flutter_weather/core/utils/app_logger.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_model.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/features/feature_weather/data/models/weather_model.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/fetch_city_use_case.dart';
import 'package:flutter_weather/features/feature_location/domain/usecases/fetch_location_usecase.dart';
import 'package:flutter_weather/features/feature_weather/domain/usecases/fetch_weather_usecase.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/save_city_usecase.dart';
import 'package:get/get.dart';

class WeatherController extends GetxController with AppLogger {
  final FetchLocationUseCase fetchLocationUseCase;
  final FetchCityUseCase fetchCityUseCase;
  final FetchWeatherUseCase fetchWeatherUseCase;
  final SaveCityUseCase saveCityUseCase;

  WeatherController(this.fetchLocationUseCase, this.fetchCityUseCase,
      this.fetchWeatherUseCase, this.saveCityUseCase);

  var locationModel = Rxn<LocationModel>();
  var cityModel = Rxn<CityModel>();
  var weatherModel = WeatherModel(dailyWeatherList: []).obs;

  var isCityLoading = false.obs;
  var isWeatherLoading = false.obs;
  var locationErrorMessage = ''.obs;
  var cityErrorMessage = ''.obs;
  var weatherErrorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    isCityLoading = true.obs;
    isWeatherLoading = true.obs;
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    try {
      final fetchedLocation = await fetchLocationUseCase.execute();
      logD(
          'Fetched location: ${fetchedLocation.latitude}, ${fetchedLocation.longitude}');
      locationModel.value = fetchedLocation;

      if (locationModel.value == null || locationModel.value?.isEmpty()) {
        _setDefaultLatLong();
      }
      await fetchCityByLocation(locationModel.value!);
      await fetchWeatherByLocation(locationModel.value!);
      isCityLoading.value = false;
      isWeatherLoading.value = false;
    } catch (e) {
      logE('Error fetching location: $e');
      locationErrorMessage.value = 'Não foi possível obter a localização.';
    }
  }

  Future<void> fetchCityByLocation(LocationModel location) async {
    try {
      isCityLoading.value = true;
      final fetchedCityData = await fetchCityUseCase.execute(location);
      logD(
          'Fetched City Data: ${fetchedCityData.name}, ${fetchedCityData.state}, ${fetchedCityData.country}');
      cityModel.value = fetchedCityData;

      if (cityModel.value == null || cityModel.value?.isEmpty()) {
        _setDefaultCity();
      } else {
        await saveCity(cityModel.value!, location);
      }
    } catch (e) {
      logE('Error fetching city: $e');
      cityErrorMessage.value = 'City not available.';
    }
  }

  Future<void> fetchWeatherByLocation(LocationModel location) async {
    try {
      isWeatherLoading.value = true;
      final fetchedWeatherData = await fetchWeatherUseCase.execute(location);

      if (fetchedWeatherData.dailyWeatherList.isNotEmpty) {
        logE('Fetched Weather Data: ${fetchedWeatherData.dailyWeatherList}');
        weatherModel.value = fetchedWeatherData;
      } else {
        logE('Weather data is empty or invalid.');
        _setDefaultWeather();
      }
    } catch (e) {
      logE('Error fetching weather: $e');
      weatherErrorMessage.value = 'Erro ao obter a previsão do tempo.';
    }
  }

  Future<void> getWeatherByCitySearch(LocationModel location) async {
    Get.offAllNamed(AppRoutes.home.path);
    isWeatherLoading.value = true;
    isCityLoading.value = true;

    locationModel.value = location;

    await fetchCityByLocation(location);
    await fetchWeatherByLocation(location);

    isCityLoading.value = false;
    isWeatherLoading.value = false;

    await saveCity(cityModel.value!, location);
  }

  Future<void> saveCity(CityModel city, LocationModel location) async {
    await saveCityUseCase
        .execute(SaveCityParams(city: city, location: location));
  }

  void _setDefaultCity() {
    //todo - buscar no banco de dados antes de setar default
    logE('Setting default city');
    cityModel.value = CityModel(
      name: 'São Paulo',
      state: 'SP',
      country: 'BR',
    );
  }

  void _setDefaultLatLong() {
    //todo - buscar no banco de dados antes de setar default
    logE('Setting default lat and long');
    locationModel.value =
        LocationModel(latitude: -23.5558, longitude: -46.6396);
  }

  void _setDefaultWeather() {
    //todo - buscar no banco de dados antes de setar default
    logE('Setting default weather');
    weatherModel.value = WeatherModel(dailyWeatherList: []);
  }
}
