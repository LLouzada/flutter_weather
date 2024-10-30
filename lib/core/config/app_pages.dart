import 'package:flutter_weather/core/config/app_routes.dart';
import 'package:flutter_weather/presentation/pages/history_page.dart';
import 'package:flutter_weather/presentation/pages/search_city_page.dart';
import 'package:flutter_weather/presentation/pages/weather_page.dart';
import 'package:flutter_weather/presentation/pages/onboarding_page.dart';
import 'package:flutter_weather/features/feature_location/presentation/pages/location_permission_page.dart';
import 'package:get/get.dart';

class AppPages {
  static GetPage home =
      GetPage(name: AppRoutes.home.path, page: () => const WeatherPage());

  static GetPage onboarding = GetPage(
      name: AppRoutes.onboarding.path, page: () => const OnboardingPage());

  static GetPage permission = GetPage(
      name: AppRoutes.permission.path,
      page: () => const LocationPermissionPage());

  static GetPage search =
      GetPage(name: AppRoutes.search.path, page: () => const SearchCityPage());

  static GetPage history =
      GetPage(name: AppRoutes.history.path, page: () => const HistoryPage());

  static GetPage settings =
      GetPage(name: AppRoutes.settings.path, page: () => const WeatherPage());

  static List<GetPage> pages = [
    home,
    history,
    permission,
    onboarding,
    settings,
    search
  ];
}
