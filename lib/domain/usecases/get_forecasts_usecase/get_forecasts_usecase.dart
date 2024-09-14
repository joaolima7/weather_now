import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/forecast_entity.dart';

abstract class GetForecastsUseCase {
  Future<Either<Exception, List<ForecastEntity>>> call(
      {String? cityName, String? lat, String? lon});
}
