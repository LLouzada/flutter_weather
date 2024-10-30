import 'package:flutter_weather/core/utils/app_logger.dart';

class CityModel with AppLogger {
  final String name;
  final String state;
  final String country;
  int? id;
  double? latitude;
  double? longitude;

  CityModel(
      {required this.name,
      required this.state,
      required this.country,
      this.id,
      this.latitude,
      this.longitude});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['city'] ??
          json['town'] ??
          json['county'] ??
          json['province'] ??
          '',
      state: '${' - ' + json['state']}, ',
      country: json['country_code']?.toUpperCase() ?? '',
    );
  }

  factory CityModel.empty() {
    return CityModel(
        name: '', state: '', country: '', id: 0, latitude: 0, longitude: 0);
  }

  isEmpty() {
    return name == '' &&
        state == '' &&
        country == '' &&
        id == 0 &&
        latitude == 0 &&
        longitude == 0;
  }
}
