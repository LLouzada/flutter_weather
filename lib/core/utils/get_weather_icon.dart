import 'package:flutter_weather/features/feature_weather/data/models/weather_model.dart';

String getWeatherIcon(WeatherCategory weatherCategory) {
  switch (weatherCategory) {
    case WeatherCategory.sun:
      return 'assets/images/weather_sunny.png';
    case WeatherCategory.cloudy:
      return 'assets/images/weather_cloudy.png';
    case WeatherCategory.storm:
      return 'assets/images/weather_storm.png';
    default:
      return 'assets/images/weather_sunny.png';
  }
}
