import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/controllers/permission_controller.dart';
import 'package:get/get.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  final double sizedBoxHeight = 60;

  @override
  Widget build(BuildContext context) {
    final PermissionController permissionController =
        Get.find<PermissionController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(Get.context!).colorScheme.primary,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        centerTitle: true,
        titleTextStyle: Theme.of(Get.context!).textTheme.headlineSmall,
        title: Text(
          'Permissão de Localização',
          style: TextStyle(color: Theme.of(Get.context!).colorScheme.onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/images/location.png'),
            SizedBox(height: sizedBoxHeight),
            Text(
              'Usamos sua localização para fornecer previsões de clima mais precisas.',
              textAlign: TextAlign.center,
              style: Theme.of(Get.context!).textTheme.titleLarge,
            ),
            SizedBox(height: sizedBoxHeight),
            SizedBox(
              width: 300, // Defina a largura que você deseja
              height: 50, // Defina a altura que você deseja
              child: FilledButton(
                onPressed: () async {
                  permissionController.handleLocastionPermission();
                },
                child: Text(
                  'Solicitar Permissão',
                  style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                      color: Theme.of(Get.context!).colorScheme.onPrimary),
                ),
              ),
            ),
            SizedBox(height: sizedBoxHeight),
          ],
        ),
      ),
    );
  }
}
