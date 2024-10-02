import 'package:flutter_weather/app/core/usecases/param_usecase.dart';
import 'package:flutter_weather/app/core/usecases/save_city_params.dart';
import 'package:flutter_weather/domain/repositories/city_repository.dart';

class SaveCityUseCase extends ParamUseCase<void, SaveCityParams> {
  final CityRepository _repository;

  SaveCityUseCase(this._repository);

  @override
  Future<void> execute(SaveCityParams params) async {
    return await _repository.saveCity(params.city, params.location);
  }
}
