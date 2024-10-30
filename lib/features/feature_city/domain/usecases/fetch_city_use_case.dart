import 'package:flutter_weather/core/core/usecases/param_usecase.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_model.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/features/feature_city/domain/repositories/city_repository.dart';

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
