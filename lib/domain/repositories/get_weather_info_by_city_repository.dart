import 'package:weather_now/domain/entities/weather_info.dart';

abstract class GetWeatherInfoByCityRepository {
  Future<List<WeatherInfoEntity>> call(String cityName);
}
