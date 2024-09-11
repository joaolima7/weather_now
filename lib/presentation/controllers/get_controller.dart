import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase.dart';
import 'package:get/get.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_geolocation/get_weather_info_by_geolocation_usecase.dart';

import '../../core/utils/utils.dart';
import '../../domain/entities/weather_info.dart';

class GetWeatherController extends GetxController {
  final GetWeatherInfoByCityUseCase _getWeatherInfoByCityUseCase;
  final GetWeatherInfoByGeolocationUseCase _getWeatherInfoByGeolocationUseCase;
  final TextEditingController txtController = TextEditingController();

  GetWeatherController(
    this._getWeatherInfoByCityUseCase,
    this._getWeatherInfoByGeolocationUseCase,
  );

  var isLoading = false.obs;
  var isSearching = false.obs;
  var weatherInfo = WeatherInfoEntity.empty().obs;

  //Posição atual para inicio
  Future<void> init() async {
    await Utils.determinePositionAndFetchWeather();
    await getWeatherByLocation();
  }

  //Buscar Weather por cidade
  Future<void> getWeatherByCityName(String cityName) async {
    try {
      isLoading.value = true;
      var result = await _getWeatherInfoByCityUseCase(cityName);
      result.fold(
        (error) => print(error),
        (sucess) => weatherInfo.value = sucess,
      );
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
      isLoading.value = false;
    }
  }

  //
  Future<void> getWeatherByLocation() async {
    try {
      isLoading.value = true;

      Position position = await Geolocator.getCurrentPosition();

      print(
          'lat: ${position.latitude.toString()} | long: ${position.longitude.toString()}');

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

  Future<void> suffixTapSearch() async {
    isSearching.value = false;
    txtController.clear();
  }

  Future<void> submitTapSearch(String query) async {
    if (query.isNotEmpty) {
      await getWeatherByCityName(query);
    } else {
      Get.snackbar('Erro', 'Digite o nome de uma cidade');
    }
  }
}
