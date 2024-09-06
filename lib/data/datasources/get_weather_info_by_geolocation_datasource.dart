import '../../domain/entities/weather_info.dart';

abstract class GetWeatherInfoByGeolocationDataSource {
  Future<WeatherInfoEntity> call(double lon, double lat);
}
