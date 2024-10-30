import 'package:flutter_weather/features/feature_city/data/models/city_model.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';

class SaveCityParams {
  final CityModel city;
  final LocationModel location;

  SaveCityParams({required this.city, required this.location});
}
