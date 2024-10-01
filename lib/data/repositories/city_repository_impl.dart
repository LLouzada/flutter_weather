import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:flutter_weather/data/models/city_description_model.dart';
import 'package:flutter_weather/data/models/city_model.dart';
import 'package:flutter_weather/data/models/location_model.dart';
import 'package:flutter_weather/data/providers/network/apis/map/map_api.dart';
import 'package:flutter_weather/domain/repositories/city_repository.dart';

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
}
