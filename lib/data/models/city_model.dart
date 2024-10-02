import 'package:flutter_weather/app/util/app_logger.dart';

class CityModel with AppLogger {
  final String name;
  final String state;
  final String country;

  CityModel({required this.name, required this.state, required this.country});

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
    return CityModel(name: '', state: '', country: '');
  }

  isEmpty() {
    return name == '' && state == '' && country == '';
  }
}
