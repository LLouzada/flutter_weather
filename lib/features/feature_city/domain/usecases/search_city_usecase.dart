import 'package:flutter_weather/core/core/usecases/param_usecase.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_description_model.dart';
import 'package:flutter_weather/features/feature_city/domain/repositories/city_repository.dart';

class SearchCityUseCase
    extends ParamUseCase<List<CityDescriptionModel>, String> {
  final CityRepository _repository;
  SearchCityUseCase(this._repository);

  @override
  Future<List<CityDescriptionModel>> execute(String params) {
    return _repository.searchCityByName(params);
  }
}
