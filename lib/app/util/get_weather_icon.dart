import 'package:flutter/material.dart';
import 'package:flutter_weather/data/models/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

IconData getWeatherIcon(WeatherCategory weatherCategory) {
  final IconData weatherIcon;

  switch (weatherCategory) {
    case WeatherCategory.sun:
      weatherIcon = WeatherIcons.day_sunny;
      break;
    case WeatherCategory.cloudy:
      weatherIcon = WeatherIcons.day_cloudy;
      {}
      break;
    case WeatherCategory.storm:
      weatherIcon = WeatherIcons.rain_wind;
      break;
    default:
      weatherIcon = WeatherIcons.day_sunny;
      break;
  }

  return weatherIcon;
}
