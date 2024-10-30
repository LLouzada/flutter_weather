enum AppRoutes {
  home,
  history,
  permission,
  onboarding,
  settings,
  search,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.home:
        return '/';
      case AppRoutes.permission:
        return '/permission';
      case AppRoutes.history:
        return '/history';
      case AppRoutes.onboarding:
        return '/onboarding';
      case AppRoutes.settings:
        return '/settings';
      case AppRoutes.search:
        return '/search';
      default:
        return '/';
    }
  }
}
