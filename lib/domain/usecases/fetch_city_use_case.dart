import 'package:flutter_weather/app/core/usecases/param_usecase.dart';
import 'package:flutter_weather/data/models/city_model.dart';
import 'package:flutter_weather/data/models/location_model.dart';
import 'package:flutter_weather/domain/repositories/city_repository.dart';

class FetchCityUseCase extends ParamUseCase<CityModel, LocationModel> {
  final CityRepository _repository;
  FetchCityUseCase(this._repository);

  @override
  Future<CityModel> execute(LocationModel params) {
    return _repository.fetchCityFromLocation(params);
  }

  Future<void> saveCity(CityModel city, LocationModel location) async {
    return await _repository.saveCity(city, location);
  }
}
