import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';
import 'package:weather_now/domain/repositories/insert_recent_city_repository.dart';
import 'package:weather_now/domain/usecases/insert_recent_city_usecases/insert_recent_city_usecase.dart';

class InsertRecentCityUsecaseImp implements InsertRecentCityUsecase {
  InsertRecentCityRepository _insertRecentCityRepository;
  InsertRecentCityUsecaseImp(this._insertRecentCityRepository);

  @override
  Future<Either<Exception, void>> call(RecentCityEntity recentCity) async {
    return await _insertRecentCityRepository(recentCity);
  }
}
