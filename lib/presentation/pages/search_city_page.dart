import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather/features/feature_location/data/models/location_model.dart';
import 'package:flutter_weather/features/feature_city/presentation/views/city_controller.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:flutter_weather/presentation/widgets/app_loader.dart';
import 'package:get/get.dart';

/// A page to search for a city
class SearchCityPage extends StatelessWidget {
  const SearchCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CityController cityController = Get.find<CityController>();
    final WeatherController weatherController = Get.find<WeatherController>();
    Timer? debounce;

    final List<Color> backgroundColors = [
      Theme.of(Get.context!).colorScheme.primaryContainer,
      Theme.of(Get.context!).colorScheme.surface,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar Cidade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                if (debounce?.isActive ?? false) debounce?.cancel();

                debounce = Timer(const Duration(milliseconds: 800), () {
                  if (value.isNotEmpty) {
                    cityController.searchCity(value);
                  } else {
                    cityController.cities.clear();
                  }
                });
              },
              decoration: const InputDecoration(
                labelText: 'Digite o nome da cidade',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            Obx(() {
              return cityController.cities.isNotEmpty
                  ? const SizedBox.shrink()
                  : const SizedBox(height: 60);
            }),
            Obx(() {
              if (cityController.isLoading.value) {
                return showLoader();
              }

              if (cityController.errorMessage.isNotEmpty) {
                return Center(child: Text(cityController.errorMessage.value));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: cityController.cities.length,
                  itemBuilder: (context, index) {
                    final city = cityController.cities[index];

                    final backgroundColor =
                        backgroundColors[index % backgroundColors.length];

                    return ListTile(
                      tileColor: backgroundColor,
                      title: Text(city.name),
                      subtitle: Text(
                          'Latitude: ${city.latitude.substring(0, 9)}, Longitude: ${city.longitude.substring(0, 9)}'),
                      onTap: () async {
                        await weatherController.getWeatherByCitySearch(
                            LocationModel(
                                latitude: double.tryParse(city.latitude) ?? 0.0,
                                longitude:
                                    double.tryParse(city.longitude) ?? 0.0));
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
