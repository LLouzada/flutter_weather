import 'package:flutter/material.dart';
import 'package:flutter_weather/app/config/app_constants.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:get/get.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final WeatherController weatherController = Get.find<WeatherController>();

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(8.0),
                height: 200,
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Obx(() {
                      if (weatherController.isWeatherLoading.value) {
                        return const CircularProgressIndicator();
                      }
                      return Row(
                        children: [
                          Text(
                            weatherController.cityModel.value?.name ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            weatherController.cityModel.value?.state ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            weatherController.cityModel.value?.country ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      );
                    }),
                    Obx(() {
                      if (weatherController.isWeatherLoading.value) {
                        return const CircularProgressIndicator();
                      }
                      return Text(
                        '${weatherController.weatherModel.value?.day1}°C',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                    Obx(() {
                      if (weatherController.isWeatherLoading.value) {
                        return const CircularProgressIndicator();
                      }
                      return Text(
                        weatherController.weatherModel.value?.day1MaxTemperature
                                .toString() ??
                            '',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      );
                    }),
                  ],
                )),
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
