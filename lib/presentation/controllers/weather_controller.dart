import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:flutter_weather/data/models/city_model.dart';
import 'package:flutter_weather/data/models/location_model.dart';
import 'package:flutter_weather/domain/usecases/fetch_city_use_case.dart';
import 'package:flutter_weather/domain/usecases/fetch_location_use_case.dart';
import 'package:get/get.dart';

class WeatherController extends GetxController with AppLogger {
  final FetchLocationUseCase fetchLocationUseCase;
  final FetchCityUseCase fetchCityUseCase;

  WeatherController(this.fetchLocationUseCase, this.fetchCityUseCase);

  var locationModel = Rxn<LocationModel>();
  var cityModel = Rxn<CityModel>();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    try {
      isLoading.value = true;
      final fetchedLocation = await fetchLocationUseCase.execute();
      logD(
          'Fetched location: ${fetchedLocation.latitude}, ${fetchedLocation.longitude}');
      locationModel.value = fetchedLocation;

      if (locationModel.value != null) {
        await fetchCityByLocation(locationModel.value!);
      } //todo - usar cidade default / ultimo histórico
    } catch (e) {
      logE('Error fetching location: $e');
      errorMessage.value = 'Location not available.';
      isLoading.value = false;
    }
  }

  Future<void> fetchCityByLocation(LocationModel location) async {
    try {
      isLoading.value = true;
      final fetchedCityData = await fetchCityUseCase.execute(location);
      logD(
          'Fetched City Data: ${fetchedCityData.name}, ${fetchedCityData.state}, ${fetchedCityData.country}');
      cityModel.value = fetchedCityData;
    } catch (e) {
      logE('Error fetching city: $e');
      errorMessage.value = 'City not available.';
    } finally {
      isLoading.value = false;
    }
  }
}
