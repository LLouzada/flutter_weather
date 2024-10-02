import 'package:flutter_weather/data/models/city_model.dart';
import 'package:flutter_weather/data/models/location_model.dart';

class SaveCityParams {
  final CityModel city;
  final LocationModel location;

  SaveCityParams({required this.city, required this.location});
}
