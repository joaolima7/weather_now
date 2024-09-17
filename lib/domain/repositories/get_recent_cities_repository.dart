import 'package:weather_now/domain/entities/recent_city_entity.dart';

abstract class GetRecentCitiesRepository {
  Future<List<RecentCityEntity>> call();
}
