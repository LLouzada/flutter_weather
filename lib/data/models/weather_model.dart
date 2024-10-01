import 'package:intl/intl.dart';

class WeatherModel {
  //today´s weather
  final String day1;
  final double day1MinTemperature;
  final double day1MaxTemperature;
  final double day1Precipitation;
  final double day1Humidity;

  WeatherModel({
    required this.day1,
    required this.day1MinTemperature,
    required this.day1MaxTemperature,
    required this.day1Precipitation,
    required this.day1Humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      day1: DateFormat('dd-MM-yyyy').format(json['day1']),
      day1MinTemperature: json['day1MinTemperature'],
      day1MaxTemperature: json['day1MaxTemperature'],
      day1Precipitation: json['day1Precipitation'],
      day1Humidity: json['day1Humidity'],
    );
  }

  factory WeatherModel.empty() {
    return WeatherModel(
      day1: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      day1MinTemperature: 0.0,
      day1MaxTemperature: 0.0,
      day1Precipitation: 0.0,
      day1Humidity: 0.0,
    );
  }

  isEmpty() {
    return day1 == '' &&
        day1MinTemperature == 0.0 &&
        day1MaxTemperature == 0.0 &&
        day1Precipitation == 0.0 &&
        day1Humidity == 0.0;
  }
}
