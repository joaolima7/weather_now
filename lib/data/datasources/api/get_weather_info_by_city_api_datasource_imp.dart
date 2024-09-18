import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_now/core/utils/conts.dart';
import 'package:weather_now/core/utils/http_manager.dart';
import 'package:weather_now/data/datasources/get_weather_info_by_city_datasource.dart';
import 'package:weather_now/data/exceptions/get_weather_info_by_city/city_not_found_exception.dart';
import 'package:weather_now/domain/entities/weather_info.dart';

class GetWeatherInfoByCityApiDataSourceImp
    implements GetWeatherInfoByCityDataSource {
  final httpManager = HttpManager(baseUrl: urlBase);
  @override
  Future<Either<Exception, WeatherInfoEntity>> call(String cityName) async {
    try {
      final response = await httpManager.get(
        '/weather',
        queryParameters: {
          'q': cityName,
          'appid': apiKey,
          'units': 'metric',
          'lang': 'pt_br',
        },
      );
      return Right(WeatherInfoEntity.fromMap(response.data));
    } catch (e) {
      return Left(CityNotFoundException('Falha ao encontrar cidade.'));
    }
  }
}
