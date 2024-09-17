import 'package:dartz/dartz.dart';
import 'package:weather_now/domain/entities/weather_info.dart';
import 'package:weather_now/domain/repositories/get_weather_info_by_geolocation_repository.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_geolocation_usecase/get_weather_info_by_geolocation_usecase.dart';

class GetWheatherInfoByGeolocationUseCaseImp
    implements GetWeatherInfoByGeolocationUseCase {
  GetWeatherInfoByGeolocationRepository _geolocationRepository;
  GetWheatherInfoByGeolocationUseCaseImp(this._geolocationRepository);
  @override
  Future<Either<Exception, WeatherInfoEntity>> call(
      {required double lon, required double lat}) async {
    return await _geolocationRepository(lon, lat);
  }
}
