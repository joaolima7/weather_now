import 'package:get_it/get_it.dart';
import 'package:weather_now/data/datasources/api/get_weather_info_by_city_api_datasource_imp.dart';
import 'package:weather_now/data/datasources/get_weather_info_by_city_datasource.dart';
import 'package:weather_now/data/repositories/get_weather_info_by_city_repository_imp.dart';
import 'package:weather_now/domain/repositories/get_weather_info_by_city_repository.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase_imp.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    //DataSources
    getIt.registerLazySingleton<GetWeatherInfoByCityDataSource>(
        () => GetWeatherInfoByCityApiDataSourceImp());

    //Repositories
    getIt.registerLazySingleton<GetWeatherInfoByCityRepository>(
        () => GetWeatherInfoByCityRepositoryImp(getIt()));

    //UseCases
    getIt.registerLazySingleton<GetWeatherInfoByCityUseCase>(
        () => GetWeatherInfoByCityUseCaseImp(getIt()));

    //Controllers
  }
}
