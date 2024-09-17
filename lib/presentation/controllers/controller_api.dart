import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_now/data/exceptions/city_not_found_exception.dart';
import 'package:weather_now/data/exceptions/geolocation_exception.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase.dart';
import 'package:get/get.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_geolocation_usecase/get_weather_info_by_geolocation_usecase.dart';
import '../../core/utils/utils.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/entities/weather_info.dart';
import '../../domain/usecases/get_forecasts_usecase/get_forecasts_usecase.dart';

class GetWeatherApiController extends GetxController {
  final GetWeatherInfoByCityUseCase _getWeatherInfoByCityUseCase;
  final GetWeatherInfoByGeolocationUseCase _getWeatherInfoByGeolocationUseCase;
  final GetForecastsUseCase _getForecastsUseCase;
  final TextEditingController txtController = TextEditingController();

  GetWeatherApiController(
    this._getWeatherInfoByCityUseCase,
    this._getWeatherInfoByGeolocationUseCase,
    this._getForecastsUseCase,
  );

//States
  var isLoading = false.obs;
  var isSearching = false.obs;
  var weatherInfo = WeatherInfoEntity.empty().obs;
  RxList<ForecastEntity> forecasts = <ForecastEntity>[].obs;

  //Position actually for initializing app
  Future<void> init() async {
    await Utils.determinePositionAndFetchWeather();
    await getWeatherByLocation();
  }

  //Search Weather by city name
  Future<void> getWeatherByCityName(String cityName) async {
    isLoading.value = true;
    var resultWeather = await _getWeatherInfoByCityUseCase(cityName);
    resultWeather.fold(
      (error) => {
        if (error is CityNotFoundException)
          {
            Utils.showGetSnackbar(
                title: 'Erro', message: error.toString(), error: true),
          }
        else
          {
            Utils.showGetSnackbar(
              title: 'Erro',
              message: 'Erro desconhecido.\nTente novamente mais tarde!',
              error: true,
            )
          }
      },
      (sucess) => weatherInfo.value = sucess,
    );
    await getForecastsByCityName(cityName);
    isLoading.value = false;
  }

  //Search weather by geolocation
  Future<void> getWeatherByLocation() async {
    isLoading.value = true;
    Position position = await Geolocator.getCurrentPosition();
    var result = await _getWeatherInfoByGeolocationUseCase(
      lat: position.latitude,
      lon: position.longitude,
    );
    result.fold(
      (error) {
        if (error is GeolocationException) {
          Utils.showGetSnackbar(
              title: 'Erro', message: error.toString(), error: true);
        } else {
          Utils.showGetSnackbar(
            title: 'Erro',
            message: 'Erro desconhecido.\nTente novamente mais tarde!',
            error: true,
          );
        }
      },
      (success) => weatherInfo.value = success,
    );
    await getForecastsByGeolocation(
      position.latitude.toString(),
      position.longitude.toString(),
    );
    isLoading.value = false;
  }

  //Search forecasts by geolocation
  Future<void> getForecastsByGeolocation(String lat, String lon) async {
    var result = await _getForecastsUseCase(
      lat: lat,
      lon: lon,
    );
    result.fold(
      (error) => null,
      (sucess) => forecasts.value = sucess,
    );
  }

  //Search forecasts by city name
  Future<void> getForecastsByCityName(String cityName) async {
    var result = await _getForecastsUseCase(cityName: cityName);
    result.fold(
      (error) => null,
      (sucess) => forecasts.value = sucess,
    );
  }

  // Filtering forecasts today
  List<ForecastEntity> getTodayForecasts() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return forecasts.where((forecast) {
      if (forecast.dtTxt != null) {
        return forecast.dtTxt!.startsWith(today);
      }
      return false;
    }).toList();
  }

  // Filtering index forecasts
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

  // Filtering forecasts except today
  List<Map<String, dynamic>> getNextPredictions() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final futureForecasts = forecasts.where((forecast) {
      if (forecast.dtTxt != null) {
        return !forecast.dtTxt!.startsWith(today);
      }
      return false;
    }).toList();

    final Map<String, List<ForecastEntity>> groupedByDate = {};
    for (var forecast in futureForecasts) {
      final date =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(forecast.dtTxt!));
      if (groupedByDate.containsKey(date)) {
        groupedByDate[date]!.add(forecast);
      } else {
        groupedByDate[date] = [forecast];
      }
    }

    // Filtering min and max temps of all in the day
    final List<Map<String, dynamic>> nextPredictions = [];
    groupedByDate.forEach((date, forecasts) {
      double minTemp =
          forecasts.map((f) => f.main.tempMin).reduce((a, b) => a < b ? a : b);
      double maxTemp =
          forecasts.map((f) => f.main.tempMax).reduce((a, b) => a > b ? a : b);

      nextPredictions.add({
        'date': date,
        'minTemp': minTemp,
        'maxTemp': maxTemp,
        'icon': forecasts.first.weather[0].icon,
      });
    });

    return nextPredictions;
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
}
