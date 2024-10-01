import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:flutter_weather/data/models/weather_model.dart';
import 'package:flutter_weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl with AppLogger implements WeatherRepository {
  @override
  Future<WeatherModel> fetchWeather() {
    return Future.value(WeatherModel.empty());
  }
}
