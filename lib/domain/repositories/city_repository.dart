import 'package:flutter_weather/data/models/city_model.dart';
import 'package:flutter_weather/data/models/location_model.dart';

abstract class CityRepository {
  Future<CityModel> fetchCityFromLocation(LocationModel location);
}
