import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';

abstract class InsertRecentCityUsecase {
  Future<Either<Exception, void>> call(RecentCityEntity recentCity);
}
