import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase.dart';
import 'package:get/get.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_geolocation/get_weather_info_by_geolocation_usecase.dart';

import '../../domain/entities/weather_info.dart';

class GetWeatherController extends GetxController {
  final GetWeatherInfoByCityUseCase _getWeatherInfoByCityUseCase;
  final GetWeatherInfoByGeolocationUseCase _getWeatherInfoByGeolocationUseCase;

  GetWeatherController(
    this._getWeatherInfoByCityUseCase,
    this._getWeatherInfoByGeolocationUseCase,
  );

  var isLoading = false.obs;
  var weatherInfo = WeatherInfoEntity.empty().obs;

  Future<void> getWeatherByCityName(String cityName) async {
    try {
      isLoading.value = true;
      WeatherInfoEntity result = await _getWeatherInfoByCityUseCase(cityName);
      weatherInfo.value = result;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Falha ao carregar dados! $e',
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: Colors.redAccent,
      );
      print(e);
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }

  Future<void> getWeatherByLocation() async {
    try {
      isLoading.value = true;

      // Request the current position
      Position position = await Geolocator.getCurrentPosition();

      print(
          'lat: ${position.latitude.toString()} | long: ${position.longitude.toString()}');

      // Fetch weather by coordinates (latitude and longitude)
      WeatherInfoEntity result = await _getWeatherInfoByGeolocationUseCase(
        lat: position.latitude,
        lon: position.longitude,
      );

      weatherInfo.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch weather data by location');
    } finally {
      isLoading.value = false;
    }
  }
}
