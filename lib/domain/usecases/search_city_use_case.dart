import 'package:flutter_weather/app/core/usecases/param_usecase.dart';
import 'package:flutter_weather/data/models/city_description_model.dart';
import 'package:flutter_weather/domain/repositories/city_repository.dart';

class SearchCityUseCase
    extends ParamUseCase<List<CityDescriptionModel>, String> {
  final CityRepository _repository;
  SearchCityUseCase(this._repository);

  @override
  Future<List<CityDescriptionModel>> execute(String params) {
    return _repository.searchCityByName(params);
  }
}
