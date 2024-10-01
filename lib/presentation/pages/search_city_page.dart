import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/controllers/city_controller.dart';
import 'package:flutter_weather/presentation/widgets/app_loader.dart';
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
                    return ListTile(
                      title: Text(city.name),
                      subtitle: Text(
                          'Latitude: ${city.latitude.substring(0, 9)}, Longitude: ${city.longitude.substring(0, 9)}'),
                      onTap: () {
                        //todo - action
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
