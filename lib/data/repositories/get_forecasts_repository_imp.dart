import 'package:dartz/dartz.dart';
import 'package:weather_now/data/datasources/get_forecasts_datasource.dart';
import 'package:weather_now/domain/entities/forecast_entity.dart';
import 'package:weather_now/domain/repositories/get_forecasts_repository.dart';

class GetForecastsRepositoryImp implements GetForecastsRepository {
  GetForecastsDatasource _getForecastsDatasource;
  GetForecastsRepositoryImp(this._getForecastsDatasource);

  @override
  Future<Either<Exception, List<ForecastEntity>>> call(
      {String? cityName, String? lat, String? lon}) async {
    return await _getForecastsDatasource(
        cityName: cityName, lat: lat, lon: lon);
  }
}
