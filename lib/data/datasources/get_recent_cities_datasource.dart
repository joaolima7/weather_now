import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';

abstract class GetRecentCitiesDatasource {
  Future<Either<Exception, List<RecentCityEntity>>> call();
}
