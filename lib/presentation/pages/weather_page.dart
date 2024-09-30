import 'package:flutter/material.dart';
import 'package:flutter_weather/app/config/app_constants.dart';
import 'package:flutter_weather/presentation/controllers/location_controller.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final LocationController locationController =
        Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(8.0),
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(Get.context!).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() {
                if (locationController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(Get.context!).colorScheme.onPrimary,
                    ),
                  );
                }

                if (locationController.errorMessage.isNotEmpty) {
                  return Text(
                      'Erro: ${locationController.errorMessage.value}'); // Mostra erro, se houver
                }

                if (locationController.location.value != null) {
                  final location = locationController.location.value!;
                  return Text(
                      'Latitude: ${location.latitude}, Longitude: ${location.longitude}');
                }

                return const Column(
                  children: [
                    Text(
                      'Temperatura Hoje',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '25°C',
                      style: TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  ],
                );
              }),
            ),
            Container(
              height: 150,
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dia ${index + 1}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '22°C',
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Mapa de Localização',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
