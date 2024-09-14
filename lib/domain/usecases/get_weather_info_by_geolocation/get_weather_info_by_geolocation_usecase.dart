import 'package:dartz/dartz.dart';

import '../../entities/weather_info.dart';

abstract class GetWeatherInfoByGeolocationUseCase {
  Future<Either<Exception, WeatherInfoEntity>> call(
      {required double lon, required double lat});
}
