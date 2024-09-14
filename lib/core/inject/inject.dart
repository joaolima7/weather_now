import 'package:get_it/get_it.dart';
import 'package:weather_now/data/datasources/api/get_forecasts_api_datasource_imp.dart';
import 'package:weather_now/data/datasources/api/get_weather_info_by_city_api_datasource_imp.dart';
import 'package:weather_now/data/datasources/api/get_weather_info_by_geolocation_api_datasource_imp.dart';
import 'package:weather_now/data/datasources/get_forecasts_datasource.dart';
import 'package:weather_now/data/datasources/get_weather_info_by_city_datasource.dart';
import 'package:weather_now/data/datasources/get_weather_info_by_geolocation_datasource.dart';
import 'package:weather_now/data/repositories/get_forecasts_repository_imp.dart';
import 'package:weather_now/data/repositories/get_weather_info_by_city_repository_imp.dart';
import 'package:weather_now/data/repositories/get_wheater_info_by_geolocation_repository_imp.dart';
import 'package:weather_now/domain/repositories/get_forecasts_repository.dart';
import 'package:weather_now/domain/repositories/get_weather_info_by_city_repository.dart';
import 'package:weather_now/domain/repositories/get_weather_info_by_geolocation_repository.dart';
import 'package:weather_now/domain/usecases/get_forecasts_usecase/get_forecasts_usecase.dart';
import 'package:weather_now/domain/usecases/get_forecasts_usecase/get_forecasts_usecase_imp.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase_imp.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_geolocation/get_weather_info_by_geolocation_usecase.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_geolocation/get_weather_info_by_geolocation_usecase_imp.dart';

import '../../presentation/controllers/get_controller.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    //DataSources
    getIt.registerLazySingleton<GetWeatherInfoByCityDataSource>(
        () => GetWeatherInfoByCityApiDataSourceImp());

    getIt.registerLazySingleton<GetForecastsDatasource>(
        () => GetForecastsApiDatasourceImp());

    getIt.registerLazySingleton<GetWeatherInfoByGeolocationDataSource>(
        () => GetWeatherInfoByGeolocationApiDataSourceImp());

    //Repositories
    getIt.registerLazySingleton<GetWeatherInfoByCityRepository>(
        () => GetWeatherInfoByCityRepositoryImp(getIt()));

    getIt.registerLazySingleton<GetWeatherInfoByGeolocationRepository>(
        () => GetWeatherInfoByGeolocationRepositoryImp(getIt()));

    getIt.registerLazySingleton<GetForecastsRepository>(
        () => GetForecastsRepositoryImp(getIt()));

    //UseCases
    getIt.registerLazySingleton<GetWeatherInfoByCityUseCase>(
        () => GetWeatherInfoByCityUseCaseImp(getIt()));

    getIt.registerLazySingleton<GetWeatherInfoByGeolocationUseCase>(
        () => GetWheatherInfoByGeolocationUseCaseImp(getIt()));

    getIt.registerLazySingleton<GetForecastsUseCase>(
        () => GetForecastsUsecaseImp(getIt()));

    //Controllers
    getIt
        .registerLazySingleton<GetWeatherController>(() => GetWeatherController(
              getIt(),
              getIt(),
              getIt(),
            ));
  }
}
