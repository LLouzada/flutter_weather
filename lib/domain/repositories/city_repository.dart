import 'package:flutter_weather/data/models/city_model.dart';

abstract class CityRepository {
  Future<CityModel> fetchCityFromLatLng(double lat, double lng);
}
