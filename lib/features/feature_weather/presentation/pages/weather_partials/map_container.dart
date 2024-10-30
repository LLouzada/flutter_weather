import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

/// A container to show the map
class MapContainer extends StatelessWidget {
  const MapContainer({
    super.key,
    required this.weatherController,
  });

  final WeatherController weatherController;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 500,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: MapBuilder(weatherController: weatherController),
      ),
    );
  }
}

/// A widget to build the map
class MapBuilder extends StatelessWidget {
  final WeatherController weatherController;

  const MapBuilder({super.key, required this.weatherController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (weatherController.isWeatherLoading.value &&
          weatherController.isCityLoading.value) {
        return const Center(
            child: CircularProgressIndicator()); // ou outra UI de loading
      }

      var location = weatherController.locationModel.value;
      var currentLatLng = LatLng(location!.latitude, location.longitude);

      return FlutterMap(
        options: MapOptions(initialCenter: currentLatLng, initialZoom: 13),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: currentLatLng,
                child: Icon(Icons.location_pin,
                    color: Theme.of(Get.context!).colorScheme.error, size: 40),
              ),
            ],
          ),
        ],
      );
    });
  }
}
