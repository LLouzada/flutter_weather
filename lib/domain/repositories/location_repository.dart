import 'package:flutter_weather/data/models/location_model.dart';

abstract class LocationRepository {
  Future<LocationModel> getCurrentLocation();
}
