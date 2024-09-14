import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/weather_info.dart';

abstract class GetWeatherInfoByGeolocationRepository {
  Future<Either<Exception, WeatherInfoEntity>> call(double lon, double lat);
}
