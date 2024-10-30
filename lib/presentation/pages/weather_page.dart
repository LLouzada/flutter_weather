import 'package:flutter/material.dart';
import 'package:flutter_weather/core/config/app_constants.dart';
import 'package:flutter_weather/core/config/app_routes.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:flutter_weather/features/feature_weather/presentation/pages/weather_partials/forecast_container.dart';
import 'package:flutter_weather/features/feature_weather/presentation/pages/weather_partials/map_container.dart';
import 'package:flutter_weather/features/feature_weather/presentation/pages/weather_partials/today_weather_conteiner.dart';
import 'package:get/get.dart';

/// The main page of the app
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
          _MainPopupMenuButton(themeController: themeController),
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
            MapContainer(weatherController: weatherController),
          ],
        ),
      ),
    );
  }
}

class _MainPopupMenuButton extends StatelessWidget {
  final ThemeController themeController;

  const _MainPopupMenuButton({
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<int>(
          icon: const Icon(Icons.menu, size: 40),
          onSelected: (value) {
            switch (value) {
              case 0:
                themeController.toggleTheme();
                break;
              case 1:
                Get.toNamed(AppRoutes.search.path);
                break;
              case 2:
                Get.toNamed(AppRoutes.history.path);
            }
          },
          itemBuilder: (context) => [
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
                  Icon(Icons.history),
                  SizedBox(width: 8),
                  Text('Historico de Cidades'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 0,
              child: Row(
                children: [
                  Icon(Icons.brightness_6),
                  SizedBox(width: 8),
                  Text('Trocar Tema'),
                ],
              ),
            ),
            // Você pode adicionar mais opções aqui
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
