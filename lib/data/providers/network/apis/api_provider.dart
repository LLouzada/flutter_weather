import 'package:flutter_weather/data/providers/network/apis/api_request_template.dart';

class ApiProvider {
  static const Duration requestTimeout = Duration(seconds: 30);

  Future<dynamic> request(ApiRequestTemplate request) async {
    return await request.request();
  }
}
