import 'package:flutter/material.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/features/feature_city/presentation/views/city_controller.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:get/get.dart';

///  A page to show the history of searches
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.find<WeatherController>();
    final CityController cityController = Get.find<CityController>();
    cityController.fetchHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Buscas'),
      ),
      body: Obx(() {
        if (cityController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cityController.savedCities.isEmpty) {
          return const Center(
              child: Text('Nenhuma cidade salva no histórico.'));
        }

        return ListView.builder(
          itemCount: cityController.savedCities.length,
          itemBuilder: (context, index) {
            final city = cityController.savedCities[index];
            return ListTile(
              title: Text(city.name),
              subtitle: Text('${city.state.substring(2)} ${city.country}'),
              onTap: () async {
                await weatherController.getWeatherByCitySearch(LocationModel(
                    latitude: city.latitude ?? 0.0,
                    longitude: city.longitude ?? 0.0));
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.delete),
        label: const Text('Limpar'),
        onPressed: () async {
          cityController
              .clearHistory(); // Chama a função para limpar o histórico
        },
      ),
    );
  }
}
