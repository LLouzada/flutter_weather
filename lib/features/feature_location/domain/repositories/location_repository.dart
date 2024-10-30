import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';

abstract class LocationRepository {
  Future<LocationModel> getCurrentLocation();
}
