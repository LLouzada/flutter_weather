import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/core/providers/network/apis/api_endpoints.dart';
import 'package:flutter_weather/core/providers/network/apis/api_provider.dart';
import 'package:flutter_weather/core/providers/network/apis/api_request_template.dart';

enum MapType { reverse, search }

class MapApi implements ApiRequestTemplate {
  final MapType type;
  final LocationModel location;
  final String name;

  MapApi._(this.type, this.location, this.name);

  MapApi.reverse(LocationModel location)
      : this._(MapType.reverse, location, '');

  MapApi.search(String name)
      : this._(MapType.search, LocationModel.empty(), name);

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
  String get path {
    switch (type) {
      case MapType.reverse:
        return 'reverse?format=json&lat=$latitude&lon=$longitude';
      case MapType.search:
        return 'search?format=json&q=$name';
    }
  }

  @override
  Map<String, String>? get query => null;

  @override
  Future request() {
    return ApiProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
