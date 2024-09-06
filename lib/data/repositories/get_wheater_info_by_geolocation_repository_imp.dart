import 'package:weather_now/data/datasources/get_weather_info_by_geolocation_datasource.dart';
import 'package:weather_now/domain/entities/weather_info.dart';
import 'package:weather_now/domain/repositories/get_weather_info_by_geolocation_repository.dart';

class GetWeatherInfoByGeolocationRepositoryImp
    implements GetWeatherInfoByGeolocationRepository {
  @override
  GetWeatherInfoByGeolocationDataSource _geolocationDataSource;
  GetWeatherInfoByGeolocationRepositoryImp(this._geolocationDataSource);
  Future<WeatherInfoEntity> call(double lon, double lat) async {
    return await _geolocationDataSource(lon, lat);
  }
}
