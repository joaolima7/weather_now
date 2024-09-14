import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/forecast_entity.dart';
import 'package:weather_now/domain/repositories/get_forecasts_repository.dart';
import 'package:weather_now/domain/usecases/get_forecasts_usecase/get_forecasts_usecase.dart';

class GetForecastsUsecaseImp implements GetForecastsUseCase {
  GetForecastsRepository _getForecastsRepository;
  GetForecastsUsecaseImp(this._getForecastsRepository);

  @override
  Future<Either<Exception, List<ForecastEntity>>> call(
      {String? cityName, String? lat, String? lon}) async {
    return await _getForecastsRepository(
        cityName: cityName, lat: lat, lon: lon);
  }
}
