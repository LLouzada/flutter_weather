import 'package:flutter_weather/app/core/usecases/no_param_usecase.dart';
import 'package:flutter_weather/domain/repositories/city_repository.dart';

class ClearHistoryUseCase extends NoParamUseCase<void> {
  final CityRepository _repository;

  ClearHistoryUseCase(this._repository);

  @override
  Future<void> execute() async {
    return await _repository.clearHistory();
  }
}
