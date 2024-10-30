import 'package:flutter/material.dart';
import 'package:flutter_weather/core/utils/get_weather_icon.dart';
import 'package:flutter_weather/presentation/controllers/weather_controller.dart';
import 'package:flutter_weather/presentation/widgets/app_loader.dart';
import 'package:get/get.dart';

///  A container to show the forecast weather
class ForecastWeatherContainer extends StatelessWidget {
  final WeatherController weatherController;

  const ForecastWeatherContainer({
    super.key,
    required this.weatherController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(() {
        if (weatherController.isWeatherLoading.value) {
          return showLoader();
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              weatherController.weatherModel.value.dailyWeatherList.length - 1,
          itemBuilder: (iBContext, index) {
            final dailyWeather = weatherController
                .weatherModel.value.dailyWeatherList[index + 1];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 140,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(dailyWeather.date.substring(0, 5),
                            style: Theme.of(Get.context!)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onPrimaryContainer,
                                )),
                        Image.asset(
                          getWeatherIcon(dailyWeather.weatherCode),
                          height: 24.0,
                          width: 24.0,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${dailyWeather.maxTemperature}°C',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${dailyWeather.minTemperature}°C',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${dailyWeather.precipitation}mm', //
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
