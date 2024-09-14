import 'package:dartz/dartz.dart';

import '../entities/forecast_entity.dart';

abstract class GetForecastsRepository {
  Future<Either<Exception, List<ForecastEntity>>> call(
      {String? cityName, String? lat, String? lon});
}
