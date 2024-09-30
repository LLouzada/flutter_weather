import 'package:flutter_weather/data/models/city_model.dart';
import 'package:flutter_weather/domain/repositories/city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  @override
  Future<CityModel> fetchCityFromLatLng(double lat, double lng) {
    //todo - implement fetchCityFromLatLng logic
    return Future.delayed(
      const Duration(seconds: 2),
      () => CityModel(name: 'São Paulo', country: 'Brasil'),
    );
  }
}
