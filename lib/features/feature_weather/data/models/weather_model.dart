import 'package:flutter_weather/core/utils/app_logger.dart';
import 'package:intl/intl.dart';

class WeatherModel with AppLogger {
  final List<DailyWeather> dailyWeatherList;

  WeatherModel({
    required this.dailyWeatherList,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List<DailyWeather> dailyWeather = [];

    List<dynamic> dates = json['daily']['time'];
    List<dynamic> minTemps = json['daily']['temperature_2m_min'];
    List<dynamic> maxTemps = json['daily']['temperature_2m_max'];
    List<dynamic> precipitations = json['daily']['precipitation_sum'];
    List<dynamic> weatherCodes = json['daily']['weather_code'];

    // todo - não tem humidade por dia no open-meteo...
    int defaultHumidity = json['current']['relative_humidity_2m'];

    for (int i = 0; i < dates.length; i++) {
      dailyWeather.add(DailyWeather(
          date: DateFormat('dd/MM/yyyy').format(DateTime.parse(dates[i])),
          minTemperature: minTemps[i],
          maxTemperature: maxTemps[i],
          precipitation: precipitations[i],
          humidity: defaultHumidity,
          weatherCode: WeatherConditions.getCategory(weatherCodes[i])));
    }

    return WeatherModel(
      dailyWeatherList: dailyWeather,
    );
  }

  factory WeatherModel.empty() {
    return WeatherModel(
      dailyWeatherList: [],
    );
  }

  bool isEmpty() {
    return dailyWeatherList.isEmpty;
  }
}

class DailyWeather {
  final String date;
  final double minTemperature;
  final double maxTemperature;
  final double precipitation;
  final int humidity;
  final WeatherCategory weatherCode;

  DailyWeather({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.precipitation,
    required this.humidity,
    required this.weatherCode,
  });
}

enum WeatherCategory { sun, cloudy, storm, empty }

class WeatherConditions {
  static WeatherCategory getCategory(int code) {
    if (code == 0 || code == 1 || code == 2 || code == 3) {
      return WeatherCategory.sun; // Clear sky and mainly clear
    } else if (code >= 45 && code <= 48 ||
        (code >= 51 && code <= 57) ||
        (code >= 61 && code <= 75) ||
        code == 77 ||
        (code >= 80 && code <= 82) ||
        (code >= 85 && code <= 86)) {
      return WeatherCategory.cloudy; // Fog, drizzle, rain, snow, etc.
    } else if (code == 95 || code == 96 || code == 99) {
      return WeatherCategory.storm; // Thunderstorms
    } else {
      return WeatherCategory.empty; // Other weather conditions
    }
  }
}
