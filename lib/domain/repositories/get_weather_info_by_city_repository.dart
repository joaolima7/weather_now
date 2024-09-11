import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/weather_info.dart';

abstract class GetWeatherInfoByCityRepository {
  Future<Either<Exception, WeatherInfoEntity>> call(String cityName);
}
