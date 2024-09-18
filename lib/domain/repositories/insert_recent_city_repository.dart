import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';

abstract class InsertRecentCityRepository {
  Future<Either<Exception, void>> call(RecentCityEntity recentCity);
}
