import 'package:flutter_weather/core/services/local_storage.dart';
import 'package:flutter_weather/presentation/controllers/boot_controller.dart';
import 'package:flutter_weather/presentation/controllers/permission_controller.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';

/// Initializes the dependency injection for the application.
///
/// This class is responsible for setting up the necessary dependencies for the
/// application initialization, including the [LocalStorageService], [BootController],
/// [LocationPermissionController], and [ThemeController].
///
/// The [boot] method should be called during the application's startup to
/// ensure that all required dependencies are properly initialized and available
/// for use throughout the application.
class DependencyInjector {
  /// Initializes the dependency injection for the application initialization.
  ///
  /// This method sets up the necessary dependencies for the application,
  /// including the [LocalStorageService], [BootController],
  /// [LocationPermissionController], and [ThemeController].
  static Future<void> boot() async {
    // Initializes the LocalStorageService asynchronously
    await Get.putAsync<LocalStorageService>(() async {
      final service = LocalStorageService();
      await service.init();
      return service;
    });

    // Registers the necessary controllers for the boot process
    Get.put(BootController());
    Get.put(LocationPermissionController());
    Get.put(ThemeController());
  }
}
