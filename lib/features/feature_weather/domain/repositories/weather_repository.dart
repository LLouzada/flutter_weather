import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/features/feature_weather/data/models/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> fetchWeather(LocationModel location);
}
