import 'package:flutter/material.dart';
import 'package:flutter_weather/core/utils/get_weather_icon.dart';
import 'package:flutter_weather/features/feature_weather/data/models/weather_model.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:flutter_weather/presentation/widgets/app_loader.dart';
import 'package:get/get.dart';

///  A container to show the today weather
class TodayWeatherContainer extends StatelessWidget {
  final WeatherController weatherController;

  const TodayWeatherContainer({
    super.key,
    required this.weatherController,
  });

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
              return showLoader(
                  color: Theme.of(Get.context!).colorScheme.onPrimary);
            }

            return Column(children: [
              _CityRow(weatherController: weatherController),
              _DateRow(weatherController: weatherController),
              const SizedBox(height: 16),
              _MaxTempRow(weatherController: weatherController),
              _MinTempRow(weatherController: weatherController),
              _PrecipitationRow(weatherController: weatherController),

              //todo - na api open meteo não tem essa informação... (pelo menos não achei)
              // Text(
              //   'Humidade: ${weatherController.weatherModel.value?.dailyWeatherList[0].humidity ?? ''}mm',
              //   style: TextStyle(
              //     fontSize: 18,
              //     color: Theme.of(Get.context!).colorScheme.onPrimary,
              //   ),
              // ),
            ]);
          },
        ));
  }
}

///  A row to show the city name
class _PrecipitationRow extends StatelessWidget {
  const _PrecipitationRow({
    required this.weatherController,
  });

  final WeatherController weatherController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Volume de Chuva: ',
          style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
        Text(
          '${weatherController.weatherModel.value.dailyWeatherList[0].precipitation}mm',
          style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
      ],
    );
  }
}

///  A row to show the min temperature
class _MinTempRow extends StatelessWidget {
  const _MinTempRow({
    required this.weatherController,
  });

  final WeatherController weatherController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Min: ',
          style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
        Text(
          '${weatherController.weatherModel.value.dailyWeatherList[0].minTemperature}°C',
          style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
      ],
    );
  }
}

///  A row to show the max temperature
class _MaxTempRow extends StatelessWidget {
  const _MaxTempRow({
    required this.weatherController,
  });

  final WeatherController weatherController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Max: ',
          style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
        Text(
          '${weatherController.weatherModel.value.dailyWeatherList[0].maxTemperature}°C',
          style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
      ],
    );
  }
}

///  A row to show the date
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
          weatherController.weatherModel.value.dailyWeatherList[0].date,
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
        ),
      ],
    );
  }
}

///  A row to show the city name
class _CityRow extends StatelessWidget {
  const _CityRow({
    required this.weatherController,
  });

  final WeatherController weatherController;

  @override
  Widget build(BuildContext context) {
    WeatherCategory weatherCategory =
        weatherController.weatherModel.value.dailyWeatherList[0].weatherCode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          weatherController.cityModel.value?.name ?? '',
          style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
        ),
        const Spacer(),
        Image.asset(
          getWeatherIcon(weatherCategory),
          height: 48.0,
          width: 48.0,
        )
      ],
    );
  }
}
