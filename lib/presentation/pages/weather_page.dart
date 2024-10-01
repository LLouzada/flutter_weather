import 'package:flutter/material.dart';
import 'package:flutter_weather/app/config/app_constants.dart';
import 'package:flutter_weather/app/config/app_routes.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:flutter_weather/presentation/pages/weather_partials/forecast_container.dart';
import 'package:flutter_weather/presentation/pages/weather_partials/today_weather.dart';
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
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu),
            onSelected: (value) {
              switch (value) {
                case 0:
                  themeController.toggleTheme();
                  break;
                case 1:
                  Get.toNamed(AppRoutes.search.path);
                  break;
                case 2:

                // Adicione mais cases se houver mais opções
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.brightness_6),
                    SizedBox(width: 8),
                    Text('Trocar tema'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(width: 8),
                    Text('Procurar Cidade'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text('Configurações'),
                  ],
                ),
              ),
              // Você pode adicionar mais opções aqui
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TodayWeatherContainer(weatherController: weatherController),
            ForecastWeatherContainer(
              weatherController: weatherController,
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
