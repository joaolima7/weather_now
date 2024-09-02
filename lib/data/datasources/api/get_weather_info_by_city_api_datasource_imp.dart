import 'package:dio/dio.dart';
import 'package:weather_now/core/utils/conts.dart';
import 'package:weather_now/core/utils/http_manager.dart';
import 'package:weather_now/data/datasources/get_weather_info_by_city_datasource.dart';
import 'package:weather_now/domain/entities/weather_info.dart';

class GetWeatherInfoByCityApiDataSourceImp
    implements GetWeatherInfoByCityDataSource {
  final httpManager = HttpManager(baseUrl: urlBase);
  @override
  Future<WeatherInfoEntity> call(String cityName) async {
    try {
      final response = await httpManager.get(
        '/weather',
        queryParameters: {
          'q': cityName,
          'appid': apiKey,
          'units': 'metric', // Opcional: para receber temperatura em Celsius
          'lang': 'pt_br', // Opcional: para receber descrição em Português
        },
      );
      return WeatherInfoEntity.fromMap(response.data);
    } on DioException catch (e) {
      throw e;
    }
  }
}
