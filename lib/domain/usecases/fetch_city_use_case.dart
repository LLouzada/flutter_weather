import 'package:flutter_weather/app/core/usecases/param_usecase.dart';
import 'package:flutter_weather/data/models/city_model.dart';
import 'package:flutter_weather/domain/repositories/city_repository.dart';
import 'package:tuple/tuple.dart';

class FetchCityUseCase extends ParamUseCase<CityModel, Tuple2<double, double>> {
  final CityRepository _repository;
  FetchCityUseCase(this._repository);

  @override
  Future<CityModel> execute(Tuple2<double, double> params) {
    return _repository.fetchCityFromLatLng(params.item1, params.item2);
  }
}
