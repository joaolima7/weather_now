import 'package:weather_now/domain/entities/weather_info.dart';

abstract class GetWeatherInfoByCityDataSource {
  Future<WeatherInfoEntity> call(String cityName);
}
