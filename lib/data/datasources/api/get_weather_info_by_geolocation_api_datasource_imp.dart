import 'package:dio/dio.dart';
import 'package:weather_now/core/utils/conts.dart';
import 'package:weather_now/core/utils/http_manager.dart';
import 'package:weather_now/data/datasources/get_weather_info_by_geolocation_datasource.dart';
import 'package:weather_now/domain/entities/weather_info.dart';

class GetWeatherInfoByGeolocationApiDataSourceImp
    implements GetWeatherInfoByGeolocationDataSource {
  @override
  Future<WeatherInfoEntity> call(double lon, double lat) async {
    final httpManager = HttpManager(baseUrl: urlBase);
    try {
      final response = await httpManager.get(
        '/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': apiKey,
          'units': 'metric',
          'lang': 'pt_br',
        },
      );
      return WeatherInfoEntity.fromMap(response.data);
    } on DioException catch (e) {
      throw e;
    }
  }
}
