import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/controllers/permission/permission_controller.dart';
import 'package:get/get.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/location.png'),
            const SizedBox(height: 20),
            Text(
              'Este aplicativo precisa de acesso à sua localização para fornecer previsões de clima mais precisas.',
              textAlign: TextAlign.center,
              style: Theme.of(Get.context!).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () async {
                permissionController.handlePermission();
              },
              child: const Text('Solicitar Permissão'),
            ),
          ],
        ),
      ),
    );
  }
}
