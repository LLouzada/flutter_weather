import 'package:flutter_weather/core/utils/app_logger.dart';

class LocationModel with AppLogger {
  final double latitude;
  final double longitude;

  LocationModel({required this.latitude, required this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['lat'] ?? -1,
      longitude: json['long'] ?? -1,
    );
  }

  factory LocationModel.empty() {
    return LocationModel(latitude: -1, longitude: -1);
  }

  isEmpty() {
    return latitude == -1 && longitude == -1;
  }
}
