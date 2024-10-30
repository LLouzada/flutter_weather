import 'package:flutter_weather/core/utils/app_logger.dart';

class CityDescriptionModel with AppLogger {
  final String name;
  final String latitude;
  final String longitude;

  CityDescriptionModel({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory CityDescriptionModel.fromJson(Map<String, dynamic> json) {
    return CityDescriptionModel(
      name: json['display_name'] ?? '',
      latitude: json['lat'] ?? '',
      longitude: json['lon'] ?? '',
    );
  }

  factory CityDescriptionModel.empty() {
    return CityDescriptionModel(
      name: '',
      latitude: '',
      longitude: '',
    );
  }

  static List<CityDescriptionModel> emptyList() {
    return [];
  }

  bool isEmpty() {
    return name.isEmpty && latitude.isEmpty && longitude.isEmpty;
  }

  static bool isListEmpty(List<CityDescriptionModel> cities) {
    return cities.isEmpty || cities.every((city) => city.isEmpty());
  }
}
