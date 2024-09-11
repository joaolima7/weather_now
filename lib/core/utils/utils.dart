import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class Utils {
  static String capitalize(String s) =>
      s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;

  static Future<void> determinePositionAndFetchWeather() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error',
          'Serviço de localização desabilitado. Habilite para continuar.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Erro', 'Permissão de localização negada.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Erro', 'Habilite a localização nas configurações.');
      return;
    }
  }
}
