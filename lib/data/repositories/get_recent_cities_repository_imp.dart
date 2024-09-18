import 'package:dartz/dartz.dart';
import 'package:weather_now/data/datasources/get_recent_cities_datasource.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';
import 'package:weather_now/domain/repositories/get_recent_cities_repository.dart';

class GetRecentCitiesRepositoryImp implements GetRecentCitiesRepository {
  GetRecentCitiesDatasource _getRecentCitiesDatasource;
  GetRecentCitiesRepositoryImp(this._getRecentCitiesDatasource);

  @override
  Future<Either<Exception, List<RecentCityEntity>>> call() async {
    return await _getRecentCitiesDatasource();
  }
}
