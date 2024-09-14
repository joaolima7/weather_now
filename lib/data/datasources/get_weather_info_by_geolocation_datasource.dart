import 'package:dartz/dartz.dart';

import '../../domain/entities/weather_info.dart';

abstract class GetWeatherInfoByGeolocationDataSource {
  Future<Either<Exception, WeatherInfoEntity>> call(double lon, double lat);
}
