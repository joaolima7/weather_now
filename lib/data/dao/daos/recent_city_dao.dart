import 'package:floor/floor.dart';
import 'package:weather_now/data/dao/floor_entities/recent_city_floor_entity.dart';

@dao
abstract class RecentCityDao {
  @Query('SELECT * FROM recent_cities ORDER BY id DESC')
  Future<List<RecentCityFloorEntity>> getAllRecentCities();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRecentCity(RecentCityFloorEntity recent_city);

  @Query(
      'DELETE FROM recent_cities WHERE id = (SELECT id FROM recent_cities ORDER BY id ASC LIMIT 1)')
  Future<void> deleteOldestRecentCity();
}
