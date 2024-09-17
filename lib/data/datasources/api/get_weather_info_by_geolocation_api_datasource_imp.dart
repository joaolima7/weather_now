import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_now/core/utils/conts.dart';
import 'package:weather_now/core/utils/http_manager.dart';
import 'package:weather_now/data/datasources/get_weather_info_by_geolocation_datasource.dart';
import 'package:weather_now/data/exceptions/geolocation_exception.dart';
import 'package:weather_now/domain/entities/weather_info.dart';

class GetWeatherInfoByGeolocationApiDataSourceImp
    implements GetWeatherInfoByGeolocationDataSource {
  @override
  Future<Either<Exception, WeatherInfoEntity>> call(
      double lon, double lat) async {
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
      return right(WeatherInfoEntity.fromMap(response.data));
    } catch (e) {
      return left(GeolocationException('Falha na localização atual.'));
    }
  }
}
