import 'package:dartz/dartz.dart';
import 'package:weather_now/data/dao/daos/recent_city_dao.dart';
import 'package:weather_now/data/dao/database.dart';
import 'package:weather_now/data/datasources/get_recent_cities_datasource.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';

class GetRecentCitiesLocalDatasourceImp implements GetRecentCitiesDatasource {
  @override
  Future<Either<Exception, List<RecentCityEntity>>> call() async {
    try {
      final database = await $FloorRecentCitiesDatabase
          .databaseBuilder('app_database.db')
          .build();
      RecentCityDao recentCityDao = database.recentCityDao;
      return Right(await recentCityDao.getAllRecentCities());
    } catch (e) {
      return Left(Exception('Erro ao recuperar recentes!'));
    }
  }
}
