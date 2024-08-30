import 'package:weather_now/domain/entities/weather_info.dart';
import 'package:weather_now/domain/repositories/get_weather_info_by_city_repository.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase.dart';

class GetWeatherInfoByCityUseCaseImp implements GetWeatherInfoByCityUseCase {
  GetWeatherInfoByCityRepository _getWeatherInfoByCityRepository;
  GetWeatherInfoByCityUseCaseImp(this._getWeatherInfoByCityRepository);

  @override
  Future<List<WeatherInfoEntity>> call(String cityName) async {
    return await _getWeatherInfoByCityRepository(cityName);
  }
}
