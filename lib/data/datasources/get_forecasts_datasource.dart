import 'package:dartz/dartz.dart';
import '../../domain/entities/forecast_entity.dart';

abstract class GetForecastsDatasource {
  Future<Either<Exception, List<ForecastEntity>>> call(
      {String? cityName, String? lat, String? lon});
}
