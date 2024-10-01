import 'package:flutter_weather/data/models/location_model.dart';
import 'package:flutter_weather/data/models/weather_model.dart';
import 'package:flutter_weather/domain/repositories/weather_repository.dart';

import '../../app/core/usecases/param_usecase.dart';

class FetchWeatherUseCase extends ParamUseCase<WeatherModel, LocationModel> {
  final WeatherRepository _repository;

  FetchWeatherUseCase(this._repository);

  @override
  Future<WeatherModel> execute(LocationModel params) {
    return _repository.fetchWeather();
  }
}
