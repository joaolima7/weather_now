import 'package:dartz/dartz.dart';
import 'package:weather_now/core/utils/conts.dart';
import 'package:weather_now/core/utils/http_manager.dart';
import 'package:weather_now/data/datasources/get_forecasts_datasource.dart';
import 'package:weather_now/domain/entities/forecast_entity.dart';

class GetForecastsApiDatasourceImp implements GetForecastsDatasource {
  final httpManager = HttpManager(baseUrl: urlBase);

  @override
  Future<Either<Exception, List<ForecastEntity>>> call(
      {String? cityName, String? lat, String? lon}) async {
    try {
      final response;
      if (cityName != null) {
        response = await httpManager.get(
          '/forecast',
          queryParameters: {
            'q': cityName,
            'appid': apiKey,
            'units': 'metric',
            'lang': 'pt_br',
          },
        );
      } else {
        response = await httpManager.get(
          '/forecast',
          queryParameters: {
            'lat': lat,
            'lon': lon,
            'appid': apiKey,
            'units': 'metric',
            'lang': 'pt_br',
          },
        );
      }

      // Extrai o corpo da resposta (response.data)
      final data = response.data;

      // Verifica se o corpo da resposta é válido e se contém 'cod'
      if (data != null && data['cod'] == "200") {
        final forecastsJson = data['list'] as List<dynamic>?;

        // Se a lista não estiver vazia, processa os dados
        if (forecastsJson != null) {
          final forecasts = forecastsJson
              .map((forecastMap) => ForecastEntity.fromMap(forecastMap))
              .toList();

          return Right(forecasts);
        } else {
          return Left(Exception('Lista de previsões vazia ou inválida!'));
        }
      } else {
        return Left(Exception(
            'Falha ao carregar previsões! Código: ${data['cod']} - Mensagem: ${data['message']}'));
      }
    } catch (e) {
      return Left(Exception('Falha ao carregar previsões!'));
    }
  }
}
