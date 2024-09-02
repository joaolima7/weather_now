import 'package:weather_now/data/datasources/get_weather_info_by_city_datasource.dart';
import 'package:weather_now/domain/entities/weather_info.dart';
import 'package:weather_now/domain/repositories/get_weather_info_by_city_repository.dart';

class GetWeatherInfoByCityRepositoryImp
    implements GetWeatherInfoByCityRepository {
  GetWeatherInfoByCityDataSource _getWeatherInfoByCityDataSource;
  GetWeatherInfoByCityRepositoryImp(this._getWeatherInfoByCityDataSource);

  @override
  Future<WeatherInfoEntity> call(String cityName) async {
    return await _getWeatherInfoByCityDataSource(cityName);
  }
}
