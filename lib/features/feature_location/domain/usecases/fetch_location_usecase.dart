import 'package:flutter_weather/core/core/usecases/no_param_usecase.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/features/feature_location/domain/repositories/location_repository.dart';

class FetchLocationUseCase extends NoParamUseCase<LocationModel> {
  final LocationRepository _repository;

  FetchLocationUseCase(this._repository);

  @override
  Future<LocationModel> execute() {
    return _repository.getCurrentLocation();
  }
}
