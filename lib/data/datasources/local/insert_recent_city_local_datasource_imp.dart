import 'package:dartz/dartz.dart';
import 'package:weather_now/data/dao/daos/recent_city_dao.dart';
import 'package:weather_now/data/dao/database.dart';
import 'package:weather_now/data/dao/floor_entities/recent_city_floor_entity.dart';
import 'package:weather_now/data/datasources/insert_recent_city_datasource.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';

class InsertRecentCityLocalDatasourceImp implements InsertRecentCityDatasource {
  @override
  Future<Either<Exception, void>> call(RecentCityEntity recentCity) async {
    try {
      final database = await $FloorRecentCitiesDatabase
          .databaseBuilder('app_database.db')
          .build();
      RecentCityDao recentCityDao = database.recentCityDao;

      final existingCity =
          await recentCityDao.findCityByName(recentCity.cityName);
      if (existingCity != null) {
        return const Right(null);
      }

      await recentCityDao.insertRecentCity(
          RecentCityFloorEntity(cityName: recentCity.cityName));

      final count = (await recentCityDao.getAllRecentCities()).length;

      if (count > 4) {
        await recentCityDao.deleteOldestRecentCity();
      }

      return const Right(null);
    } catch (e) {
      return Left(Exception('Erro nas cidades recentes!'));
    }
  }
}
