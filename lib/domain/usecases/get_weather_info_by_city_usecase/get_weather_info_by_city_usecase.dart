import 'package:weather_now/domain/entities/weather_info.dart';

abstract class GetWeatherInfoByCityUseCase {
  Future<WeatherInfoEntity> call(String cityName);
}
