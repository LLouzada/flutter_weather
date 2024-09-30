import 'package:flutter_weather/data/models/location_model.dart';
import 'package:flutter_weather/domain/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<LocationModel> getCurrentLocation() async {
    // Verifica se o serviço de localização está habilitado
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //todo - use default location / previous location
      throw Exception('Serviço de localização desabilitado');
    }

    // Verifica as permissões de localização
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        //todo - use default location / previous location
        throw Exception('Permissão de localização não concedida');
      }
    }

    // Obtém a posição atual do usuário
    Position position = await Geolocator.getCurrentPosition();

    // Converte Position para LocationModel
    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
