import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:flutter_weather/data/models/city_model.dart';
import 'package:flutter_weather/data/models/location_model.dart';
import 'package:flutter_weather/data/models/weather_model.dart';
import 'package:flutter_weather/domain/usecases/fetch_city_use_case.dart';
import 'package:flutter_weather/domain/usecases/fetch_location_use_case.dart';
import 'package:flutter_weather/domain/usecases/fetch_weather_use_case.dart';
import 'package:get/get.dart';

class WeatherController extends GetxController with AppLogger {
  final FetchLocationUseCase fetchLocationUseCase;
  final FetchCityUseCase fetchCityUseCase;
  final FetchWeatherUseCase fetchWeatherUseCase;

  WeatherController(this.fetchLocationUseCase, this.fetchCityUseCase,
      this.fetchWeatherUseCase);

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
    } catch (e) {
      logE('Error fetching location: $e');
      locationErrorMessage.value = 'Não foi possível obter a localização.';
      isCityLoading.value = false;
      isWeatherLoading.value = false;
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

      // Verifique se os dados são válidos e se a lista contém elementos
      if (fetchedWeatherData.dailyWeatherList.isNotEmpty) {
        logE('Fetched Weather Data: ${fetchedWeatherData.dailyWeatherList}');
        weatherModel.value = fetchedWeatherData;
      } else {
        logE('Weather data is empty or invalid.');
        _setDefaultWeather(); // Define um valor padrão se os dados estiverem vazios
      }
    } catch (e) {
      logE('Error fetching weather: $e');
      weatherErrorMessage.value = 'Erro ao obter a previsão do tempo.';
    } finally {
      isWeatherLoading.value = false;
      isCityLoading.value = false;
    }
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
