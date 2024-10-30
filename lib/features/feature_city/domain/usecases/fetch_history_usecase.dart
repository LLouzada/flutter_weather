import 'package:flutter_weather/core/core/usecases/no_param_usecase.dart';
import 'package:flutter_weather/features/feature_city/data/models/city_model.dart';
import 'package:flutter_weather/features/feature_city/domain/repositories/city_repository.dart';

class FetchHistoryUsecase extends NoParamUseCase<List<CityModel>> {
  final CityRepository _repository;
  FetchHistoryUsecase(this._repository);

  @override
  Future<List<CityModel>> execute() {
    return _repository.fetchHistory();
  }
}
