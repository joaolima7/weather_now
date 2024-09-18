import 'package:dartz/dartz.dart';
import 'package:weather_now/data/datasources/insert_recent_city_datasource.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';
import 'package:weather_now/domain/repositories/insert_recent_city_repository.dart';

class InsertRecentCityRepositoryImp implements InsertRecentCityRepository {
  InsertRecentCityDatasource _insertRecentCityDatasource;
  InsertRecentCityRepositoryImp(this._insertRecentCityDatasource);
  @override
  Future<Either<Exception, void>> call(RecentCityEntity recentCity) async {
    return await _insertRecentCityDatasource(recentCity);
  }
}
