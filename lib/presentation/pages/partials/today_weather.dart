import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:get/get.dart';

class TodayWeatherContainer extends StatelessWidget {
  const TodayWeatherContainer({
    super.key,
    required this.weatherController,
  });

  final WeatherController weatherController;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(8.0),
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () {
            if (weatherController.isWeatherLoading.value &&
                weatherController.isCityLoading.value) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ));
            }
            return Column(children: [
              _CityRow(weatherController: weatherController),
              _DateRow(weatherController: weatherController),
              Text(
                weatherController.weatherModel.value?.day1MaxTemperature
                        .toString() ??
                    '',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(Get.context!).colorScheme.onPrimary,
                ),
              )
            ]);
          },
        ));
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.weatherController,
  });

  final WeatherController weatherController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          weatherController.weatherModel.value?.day1 ?? '',
          style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
        Text(
          weatherController.cityModel.value?.state ?? '',
          style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
        Text(
          weatherController.cityModel.value?.country ?? '',
          style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        )
      ],
    );
  }
}

class _CityRow extends StatelessWidget {
  const _CityRow({
    required this.weatherController,
  });

  final WeatherController weatherController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          weatherController.cityModel.value?.name ?? '',
          style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
      ],
    );
  }
}
