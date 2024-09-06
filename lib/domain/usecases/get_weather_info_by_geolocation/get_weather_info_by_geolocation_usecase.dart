import '../../entities/weather_info.dart';

abstract class GetWeatherInfoByGeolocationUseCase {
  Future<WeatherInfoEntity> call({required double lon, required double lat});
}
