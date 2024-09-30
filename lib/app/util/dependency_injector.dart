import 'package:flutter_weather/app/services/local_storage.dart';
import 'package:flutter_weather/presentation/controllers/boot_controller.dart';
import 'package:flutter_weather/presentation/controllers/permission_controller.dart';
import 'package:flutter_weather/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static Future<void> boot() async {
    // Inicializa o LocalStorageService de forma assíncrona
    await Get.putAsync<LocalStorageService>(() async {
      final service = LocalStorageService();
      await service.init();
      return service;
    });

    // Controllers necessário no boot
    Get.put(BootController());
    Get.put(PermissionController());
    Get.put(ThemeController());
  }
}
