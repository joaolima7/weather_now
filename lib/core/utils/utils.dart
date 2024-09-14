import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  //Formating initial letter
  static String capitalize(String s) =>
      s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;

  //Formatting date
  static String formatedNowDate() =>
      DateFormat('MMM, dd', 'pt_BR').format(DateTime.now()).toString();

  //Path Web Weather Icon
  static String getPathIconWeather(String iconPath) =>
      'https://openweathermap.org/img/wn/${iconPath}@2x.png';

  //Get Position By Geolocation
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

  //GetSnackBar
  static showGetSnackbar({
    required String title,
    required String message,
    bool error = false,
  }) =>
      Get.snackbar(
        title,
        message,
        colorText: Colors.white,
        backgroundColor: error ? Colors.redAccent : Colors.greenAccent,
        icon: Icon(error ? Icons.error : Icons.check_circle_rounded),
        backgroundGradient:
            LinearGradient(colors: [Colors.red, Colors.redAccent]),
      );
}
