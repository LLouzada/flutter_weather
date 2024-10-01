import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/controllers/city_controller.dart';
import 'package:get/get.dart';

class SearchCityPage extends StatelessWidget {
  const SearchCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CityController cityController = Get.find<CityController>();
    Timer? debounce;

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

                debounce = Timer(const Duration(milliseconds: 500), () {
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
            const SizedBox(height: 16),
            Obx(() {
              if (cityController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (cityController.errorMessage.isNotEmpty) {
                return Center(child: Text(cityController.errorMessage.value));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: cityController.cities.length,
                  itemBuilder: (context, index) {
                    final city = cityController.cities[index];
                    return ListTile(
                      title: Text(city.name),
                      subtitle: Text(
                          'Latitude: ${city.latitude}, Longitude: ${city.longitude}'),
                      onTap: () {
                        // Ação ao clicar na cidade (ex: navegar para detalhes)
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
