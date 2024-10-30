import 'package:flutter_weather/core/utils/app_logger.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_description_model.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_model.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/clear_history_usecase.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/fetch_history_usecase.dart';
import 'package:flutter_weather/features/feature_city/domain/usecases/search_city_usecase.dart';
import 'package:get/get.dart';

class CityController extends GetxController with AppLogger {
  final SearchCityUseCase searchCityUseCase;
  final ClearHistoryUseCase clearHistoryUseCase;
  final FetchHistoryUsecase fetchHistoryUsecase;

  CityController(this.searchCityUseCase, this.clearHistoryUseCase,
      this.fetchHistoryUsecase);

  var cities = <CityDescriptionModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var savedCities = <CityModel>[].obs;

  void searchCity(String query) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final cities = await searchCityUseCase.execute(query);
      this.cities.value = cities;
    } catch (e) {
      errorMessage.value = 'Erro ao buscar cidades. $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final savedCidties = await fetchHistoryUsecase.execute();
      savedCities.value = savedCidties;
      logD('Cities fetched: ${cities.length}');
    } catch (e) {
      errorMessage.value = 'Erro ao buscar histórico. $e';
      logE('Error fetching history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearHistory() {
    clearHistoryUseCase.execute();
    savedCities.clear();
  }
}
