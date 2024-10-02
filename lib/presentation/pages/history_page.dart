import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/controllers/city_controller.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CityController cityController = Get.find<CityController>();
    cityController.fetchHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Buscas'),
      ),
      body: Obx(() {
        if (cityController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cityController.savedCities.isEmpty) {
          return const Center(
              child: Text('Nenhuma cidade salva no histórico.'));
        }

        return ListView.builder(
          itemCount: cityController.savedCities.length,
          itemBuilder: (context, index) {
            final city = cityController.savedCities[index];
            return ListTile(
              title: Text(city.name),
              subtitle: Text('Estado: ${city.state}, País: ${city.country}'),
              onTap: () {
                //todo Implementar ação ao clicar em uma cidade salva no histórico
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.delete),
        label: const Text('Limpar'),
        onPressed: () async {
          cityController
              .clearHistory(); // Chama a função para limpar o histórico
        },
      ),
    );
  }
}
