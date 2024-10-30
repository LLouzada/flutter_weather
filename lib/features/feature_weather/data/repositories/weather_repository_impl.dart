import 'package:flutter_weather/core/utils/app_logger.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/features/feature_weather/data/models/weather_model.dart';
import 'package:flutter_weather/core/providers/network/apis/weather/wheather_api.dart';
import 'package:flutter_weather/features/feature_weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl with AppLogger implements WeatherRepository {
  @override
  Future<WeatherModel> fetchWeather(LocationModel location) async {
    final WeatherApi weatherApi = WeatherApi.forecast(location);
    final response = await weatherApi.request();
    logD('Fetching weather: $response');

    if (response != null && response is Map<String, dynamic>) {
      return WeatherModel.fromJson(response);
    }

    return WeatherModel.empty();
  }
}
