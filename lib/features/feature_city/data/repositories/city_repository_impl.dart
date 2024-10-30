import 'package:flutter_weather/core/utils/app_logger.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_description_model.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_model.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/core/providers/database/database_provider.dart';
import 'package:flutter_weather/core/providers/network/apis/map/map_api.dart';
import 'package:flutter_weather/features/feature_city/domain/repositories/city_repository.dart';

class CityRepositoryImpl with AppLogger implements CityRepository {
  @override
  Future<CityModel> fetchCityFromLocation(LocationModel location) async {
    final mapApi = MapApi.reverse(location);
    final response = await mapApi.request();

    logD(
      'Fetching city from location: ${location.latitude}, ${location.longitude}, response: $response',
    );

    if (response != null && response is Map<String, dynamic>) {
      final address = response['address'];
      return CityModel.fromJson(address);
    }

    return CityModel.empty();
  }

  @override
  Future<List<CityDescriptionModel>> searchCityByName(String name) async {
    final mapApi = MapApi.search(name);
    final response = await mapApi.request();

    logD(
      'Searching city by name: $name, response: $response',
    );

    if (response != null && response is List) {
      return response.map((e) => CityDescriptionModel.fromJson(e)).toList();
    }

    return CityDescriptionModel.emptyList();
  }

  @override
  Future<void> saveCity(CityModel city, LocationModel location) async {
    final databaseProvider = DatabaseProvider();
    return databaseProvider.saveCity(city, location);
  }

  @override
  Future<List<CityModel>> fetchHistory() {
    final databaseProvider = DatabaseProvider();
    Future<List<CityModel>> cities = databaseProvider.getCities();
    logE('Fetching history: $cities');
    return cities;
  }

  @override
  Future<void> clearHistory() async {
    final databaseProvider = DatabaseProvider();
    return databaseProvider.clearHistory();
  }
}
