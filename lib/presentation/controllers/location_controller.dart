import 'package:flutter_weather/app/util/app_logger.dart';
import 'package:flutter_weather/data/models/location_model.dart';
import 'package:flutter_weather/domain/usecases/fetch_location_use_case.dart';
import 'package:get/get.dart';

class LocationController extends GetxController with AppLogger {
  final FetchLocationUseCase fetchLocationUseCase;

  LocationController(this.fetchLocationUseCase);

  var location = Rxn<LocationModel>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    try {
      isLoading.value = true;
      final fetchedLocation = await fetchLocationUseCase.execute();
      location.value = fetchedLocation;
    } catch (e) {
      logd('Error fetching location: $e');
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
