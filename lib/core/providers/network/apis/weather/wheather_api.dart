import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/core/providers/network/apis/api_endpoints.dart';
import 'package:flutter_weather/core/providers/network/apis/api_provider.dart';
import 'package:flutter_weather/core/providers/network/apis/api_request_template.dart';

enum WeatherType { current, forecast }

class WeatherApi extends ApiRequestTemplate {
  final WeatherType type;
  final LocationModel location;

  WeatherApi._(this.type, this.location);

  WeatherApi.forecast(LocationModel location)
      : this._(WeatherType.forecast, location);

  @override
  get body => '';

  @override
  String get endpoint => ApiEndpoit.openMeteoApi;

  @override
  Map<String, String>? get headers => null;

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String get path =>
      'forecast?latitude=${location.latitude}&longitude=${location.longitude}&current=relative_humidity_2m&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&forecast_days=10';

  @override
  Map<String, String>? get query => null;

  @override
  Future request() {
    return ApiProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
