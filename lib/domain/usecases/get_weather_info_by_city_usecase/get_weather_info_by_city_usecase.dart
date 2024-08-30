import 'package:weather_now/domain/entities/weather_info.dart';

abstract class GetWeatherInfoByCityUseCase {
  Future<List<WeatherInfoEntity>> call(String cityName);
}
