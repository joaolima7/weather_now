import 'package:get_it/get_it.dart';
import 'package:weather_now/data/datasources/api/get_forecasts_api_datasource_imp.dart';
import 'package:weather_now/data/datasources/api/get_weather_info_by_city_api_datasource_imp.dart';
import 'package:weather_now/data/datasources/api/get_weather_info_by_geolocation_api_datasource_imp.dart';
import 'package:weather_now/data/datasources/get_forecasts_datasource.dart';
import 'package:weather_now/data/datasources/get_recent_cities_datasource.dart';
import 'package:weather_now/data/datasources/get_weather_info_by_city_datasource.dart';
import 'package:weather_now/data/datasources/get_weather_info_by_geolocation_datasource.dart';
import 'package:weather_now/data/datasources/insert_recent_city_datasource.dart';
import 'package:weather_now/data/datasources/local/get_recent_cities_local_datasource_imp.dart';
import 'package:weather_now/data/datasources/local/insert_recent_city_local_datasource_imp.dart';
import 'package:weather_now/data/repositories/get_forecasts_repository_imp.dart';
import 'package:weather_now/data/repositories/get_recent_cities_repository_imp.dart';
import 'package:weather_now/data/repositories/get_weather_info_by_city_repository_imp.dart';
import 'package:weather_now/data/repositories/get_wheater_info_by_geolocation_repository_imp.dart';
import 'package:weather_now/data/repositories/insert_recent_city_repository_imp.dart';
import 'package:weather_now/domain/repositories/get_forecasts_repository.dart';
import 'package:weather_now/domain/repositories/get_recent_cities_repository.dart';
import 'package:weather_now/domain/repositories/get_weather_info_by_city_repository.dart';
import 'package:weather_now/domain/repositories/get_weather_info_by_geolocation_repository.dart';
import 'package:weather_now/domain/repositories/insert_recent_city_repository.dart';
import 'package:weather_now/domain/usecases/get_forecasts_usecase/get_forecasts_usecase.dart';
import 'package:weather_now/domain/usecases/get_forecasts_usecase/get_forecasts_usecase_imp.dart';
import 'package:weather_now/domain/usecases/get_recent_cities_usecases/get_recent_cities_usecase.dart';
import 'package:weather_now/domain/usecases/get_recent_cities_usecases/get_recent_cities_usecase_imp.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase_imp.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_geolocation_usecase/get_weather_info_by_geolocation_usecase.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_geolocation_usecase/get_weather_info_by_geolocation_usecase_imp.dart';
import 'package:weather_now/domain/usecases/insert_recent_city_usecases/insert_recent_city_usecase.dart';
import 'package:weather_now/domain/usecases/insert_recent_city_usecases/insert_recent_city_usecase_imp.dart';
import 'package:weather_now/presentation/controllers/controller_dao.dart';

import '../../presentation/controllers/controller_api.dart';

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

    getIt.registerLazySingleton<GetRecentCitiesDatasource>(
        () => GetRecentCitiesLocalDatasourceImp());

    getIt.registerLazySingleton<InsertRecentCityDatasource>(
        () => InsertRecentCityLocalDatasourceImp());

    //Repositories
    getIt.registerLazySingleton<GetWeatherInfoByCityRepository>(
        () => GetWeatherInfoByCityRepositoryImp(getIt()));

    getIt.registerLazySingleton<GetWeatherInfoByGeolocationRepository>(
        () => GetWeatherInfoByGeolocationRepositoryImp(getIt()));

    getIt.registerLazySingleton<GetForecastsRepository>(
        () => GetForecastsRepositoryImp(getIt()));

    getIt.registerLazySingleton<GetRecentCitiesRepository>(
        () => GetRecentCitiesRepositoryImp(getIt()));

    getIt.registerLazySingleton<InsertRecentCityRepository>(
        () => InsertRecentCityRepositoryImp(getIt()));

    //UseCases
    getIt.registerLazySingleton<GetWeatherInfoByCityUseCase>(
        () => GetWeatherInfoByCityUseCaseImp(getIt()));

    getIt.registerLazySingleton<GetWeatherInfoByGeolocationUseCase>(
        () => GetWheatherInfoByGeolocationUseCaseImp(getIt()));

    getIt.registerLazySingleton<GetForecastsUseCase>(
        () => GetForecastsUsecaseImp(getIt()));

    getIt.registerLazySingleton<GetRecentCitiesUseCase>(
        () => GetRecentCitiesUsecaseImp(getIt()));

    getIt.registerLazySingleton<InsertRecentCityUsecase>(
        () => InsertRecentCityUsecaseImp(getIt()));

    //Controllers
    getIt.registerLazySingleton<GetWeatherApiController>(
        () => GetWeatherApiController(
              getIt(),
              getIt(),
              getIt(),
            ));

    getIt.registerLazySingleton<GetWeatherDaoController>(
        () => GetWeatherDaoController(
              getIt(),
              getIt(),
            ));
  }
}
