import 'package:flutter_weather/features/feature_city/data/models/city_description_model.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_model.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';

abstract class CityRepository {
  Future<CityModel> fetchCityFromLocation(LocationModel location);

  Future<List<CityDescriptionModel>> searchCityByName(String name);

  Future<void> saveCity(CityModel city, LocationModel location);

  Future<List<CityModel>> fetchHistory();

  Future<void> clearHistory();
}
