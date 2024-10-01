import 'package:flutter_weather/data/models/location_model.dart';
import 'package:flutter_weather/data/providers/network/apis/api_endpoints.dart';
import 'package:flutter_weather/data/providers/network/apis/api_provider.dart';
import 'package:flutter_weather/data/providers/network/apis/api_request_template.dart';

enum MapType { reverse }

class MapApi implements ApiRequestTemplate {
  final MapType type;
  final LocationModel location;

  MapApi._(this.type, this.location);

  MapApi.reverse(LocationModel location) : this._(MapType.reverse, location);

  late final latitude = location.latitude;
  late final longitude = location.longitude;

  @override
  get body => '';

  @override
  String get endpoint => ApiEndpoit.openStreetMapApi;

  @override
  Map<String, String>? get headers => null;

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String get path => 'reverse?format=json&lat=$latitude&lon=$longitude';

  @override
  Map<String, String>? get query => null;

  @override
  Future request() {
    return ApiProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
