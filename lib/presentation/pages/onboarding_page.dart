import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_weather/presentation/controllers/onboarding_controller.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  final double backgroundHeight = 400;
  final double backgroundWidth = 320;
  final double containerPadding = 40;
  final double imageSpace = 400;
  final double textSpace = 20;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(Get.context!).size;
    final OnboardingController obController = Get.find<OnboardingController>();
    return OnBoardingSlider(
        totalPage: 3,
        controllerColor: Theme.of(Get.context!).colorScheme.primary,
        headerBackgroundColor: Theme.of(context).colorScheme.primary,
        imageHorizontalOffset: ((size.width - backgroundWidth) / 2),
        finishButtonText: 'Vamos lá!',
        finishButtonStyle: FinishButtonStyle(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        onFinish: () => {obController.onFinish()},
        skipTextButton:
            Text('Pular', style: Theme.of(Get.context!).textTheme.titleLarge),
        trailing: Text(
          '',
          style: Theme.of(Get.context!).textTheme.titleLarge,
        ),
        background: [
          Image.asset(
            'assets/images/onboarding_rain.png',
            height: backgroundHeight,
            width: backgroundWidth,
          ),
          Image.asset('assets/images/onboarding_wind.png',
              height: backgroundHeight, width: backgroundWidth),
          Image.asset('assets/images/onboarding_sun.png',
              height: backgroundHeight, width: backgroundWidth),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: containerPadding),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: imageSpace,
                  ),
                  Text(
                    'Acompanhe a Previsão do Tempo',
                    style: Theme.of(Get.context!).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: textSpace,
                  ),
                  Text(
                      'Acompanhe a previsão do tempo em qualquer lugar do mundo.',
                      style: Theme.of(Get.context!).textTheme.titleSmall,
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: textSpace * 2,
                  ),
                ]),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: containerPadding),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: imageSpace,
                  ),
                  Text(
                    'Offline First',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: textSpace,
                  ),
                  Text(
                      'Mesmo sem conexão com a internet, você pode acompanhar a previsão do tempo a partir de dados armazenados localmente.',
                      style: Theme.of(Get.context!).textTheme.titleSmall,
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: textSpace * 2,
                  ),
                ]),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: containerPadding),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: imageSpace,
                  ),
                  Text(
                    '',
                    style: Theme.of(Get.context!).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: textSpace,
                  ),
                  Text('',
                      style: Theme.of(Get.context!).textTheme.titleSmall,
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: textSpace * 2,
                  ),
                ]),
          ),
        ]);
  }
}
