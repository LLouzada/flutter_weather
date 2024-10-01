import 'package:flutter_weather/data/models/city_description_model.dart';
import 'package:flutter_weather/domain/usecases/search_city_use_case.dart';
import 'package:get/get.dart';

class CityController extends GetxController {
  final SearchCityUseCase searchCityUseCase;

  CityController(this.searchCityUseCase);

  var cities = <CityDescriptionModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void searchCity(String query) async {
    isLoading.value = true;
    errorMessage.value = '';

    final cities = await searchCityUseCase.execute(query);
    this.cities.value = cities;

    // errorMessage.value = 'Erro ao buscar cidades. $e';

    isLoading.value = false;
  }
}
