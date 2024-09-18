import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';
import 'package:weather_now/domain/repositories/get_recent_cities_repository.dart';
import 'package:weather_now/domain/usecases/get_recent_cities_usecases/get_recent_cities_usecase.dart';

class GetRecentCitiesUsecaseImp implements GetRecentCitiesUseCase {
  GetRecentCitiesRepository _getRecentCitiesRepository;
  GetRecentCitiesUsecaseImp(this._getRecentCitiesRepository);

  @override
  Future<Either<Exception, List<RecentCityEntity>>> call() async {
    return await _getRecentCitiesRepository();
  }
}
