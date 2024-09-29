import 'package:flutter_weather/presentation/pages/home/home_page.dart';
import 'package:get/get.dart';

class AppPages {
  static GetPage home = GetPage(name: '/', page: () => const HomePage());

  static GetPage history =
      GetPage(name: '/history', page: () => const HomePage());

  static GetPage onboarding =
      GetPage(name: '/onboarding', page: () => const HomePage());

  static GetPage settings =
      GetPage(name: '/settings', page: () => const HomePage());

  static List<GetPage> pages = [
    home,
    history,
    onboarding,
    settings,
  ];
}
