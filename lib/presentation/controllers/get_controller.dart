import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase.dart';
import 'package:get/get.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_geolocation/get_weather_info_by_geolocation_usecase.dart';
import '../../core/utils/utils.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/entities/weather_info.dart';
import '../../domain/usecases/get_forecasts_usecase/get_forecasts_usecase.dart';

class GetWeatherController extends GetxController {
  final GetWeatherInfoByCityUseCase _getWeatherInfoByCityUseCase;
  final GetWeatherInfoByGeolocationUseCase _getWeatherInfoByGeolocationUseCase;
  final GetForecastsUseCase _getForecastsUseCase;
  final TextEditingController txtController = TextEditingController();

  GetWeatherController(
    this._getWeatherInfoByCityUseCase,
    this._getWeatherInfoByGeolocationUseCase,
    this._getForecastsUseCase,
  );

  var isLoading = false.obs;
  var isSearching = false.obs;
  var weatherInfo = WeatherInfoEntity.empty().obs;
  RxList<ForecastEntity> forecasts = <ForecastEntity>[].obs;

  //Posição atual para inicio
  Future<void> init() async {
    await Utils.determinePositionAndFetchWeather();
    await getWeatherByLocation();
  }

  //Buscar Weather por cidade
  Future<void> getWeatherByCityName(String cityName) async {
    isLoading.value = true;
    var resultWeather = await _getWeatherInfoByCityUseCase(cityName);
    resultWeather.fold(
      (error) => Utils.showGetSnackbar(
          title: 'Erro', message: error.toString(), error: true),
      (sucess) => weatherInfo.value = sucess,
    );
    await getForecastsByCityName(cityName);
    isLoading.value = false;
  }

  //
  Future<void> getWeatherByLocation() async {
    isLoading.value = true;
    Position position = await Geolocator.getCurrentPosition();
    var result = await _getWeatherInfoByGeolocationUseCase(
      lat: position.latitude,
      lon: position.longitude,
    );
    result.fold(
        (error) => Utils.showGetSnackbar(
            title: 'Erro', message: error.toString(), error: true),
        (sucess) => weatherInfo.value = sucess);
    await getForecastsByGeolocation(
        position.latitude.toString(), position.longitude.toString());
    isLoading.value = false;
  }

  Future<void> getForecastsByGeolocation(String lat, String lon) async {
    var result = await _getForecastsUseCase(
      lat: lat,
      lon: lon,
    );
    result.fold(
      (error) => Utils.showGetSnackbar(
          title: 'Erro', message: error.toString(), error: true),
      (sucess) => forecasts.value = sucess,
    );
  }

  Future<void> getForecastsByCityName(String cityName) async {
    var result = await _getForecastsUseCase(cityName: cityName);
    result.fold(
      (error) => Utils.showGetSnackbar(
          title: 'Erro', message: error.toString(), error: true),
      (sucess) => forecasts.value = sucess,
    );
  }

  // Função para filtrar as previsões de hoje
  List<ForecastEntity> getTodayForecasts() {
    // Formata a data atual no mesmo formato do `dtTxt`
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Filtra as previsões com base na data
    return forecasts.where((forecast) {
      if (forecast.dtTxt != null) {
        return forecast.dtTxt!.startsWith(today);
      }
      return false;
    }).toList();
  }

  // Função para encontrar o índice da previsão mais próxima do horário atual
  int findClosestForecastIndex(List<ForecastEntity> todayForecasts) {
    final now = DateTime.now();
    int closestIndex = 0;
    Duration smallestDifference =
        Duration(hours: 24); // Diferença máxima inicial

    for (int i = 0; i < todayForecasts.length; i++) {
      final forecastTime = DateTime.parse(todayForecasts[i].dtTxt!);
      final difference = forecastTime.difference(now).abs();

      if (difference < smallestDifference) {
        smallestDifference = difference;
        closestIndex = i;
      }
    }

    return closestIndex;
  }

  //SearchBar SuffixTapSearch
  Future<void> suffixTapSearch() async {
    isSearching.value = false;
    txtController.clear();
  }

  //SearchBar Submit
  Future<void> submitTapSearch(String query) async {
    if (query.isNotEmpty) {
      await getWeatherByCityName(query);
    } else {
      Utils.showGetSnackbar(
          title: 'Erro', message: 'Busque uma cidade válida!');
    }
  }

  Future<void> teste() async {
    var result = await _getForecastsUseCase(cityName: 'Sao Paulo');
  }
}
