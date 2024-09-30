import 'package:flutter_weather/app/config/app_routes.dart';
import 'package:flutter_weather/presentation/pages/home/home_page.dart';
import 'package:flutter_weather/presentation/pages/onboarding/onboarding_page.dart';
import 'package:flutter_weather/presentation/pages/permission/permission_page.dart';
import 'package:get/get.dart';

class AppPages {
  static GetPage home =
      GetPage(name: AppRoutes.home.path, page: () => const HomePage());

  static GetPage onboarding = GetPage(
      name: AppRoutes.onboarding.path, page: () => const OnboardingPage());

  static GetPage permission =
      GetPage(name: AppRoutes.permission.path, page: () => PermissionPage());

  static GetPage history =
      GetPage(name: AppRoutes.history.path, page: () => const HomePage());

  static GetPage settings =
      GetPage(name: AppRoutes.settings.path, page: () => const HomePage());

  static List<GetPage> pages = [
    home,
    history,
    permission,
    onboarding,
    settings,
  ];
}
