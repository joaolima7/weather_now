import 'package:weather_now/domain/entities/weather_info.dart';

abstract class GetWeatherInfoByGeolocationRepository {
  Future<WeatherInfoEntity> call(double lon, double lat);
}
