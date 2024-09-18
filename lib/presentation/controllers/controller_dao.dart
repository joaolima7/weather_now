import 'package:get/get.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';
import 'package:weather_now/domain/usecases/get_recent_cities_usecases/get_recent_cities_usecase.dart';
import 'package:weather_now/domain/usecases/insert_recent_city_usecases/insert_recent_city_usecase.dart';

class GetWeatherDaoController extends GetxController {
  final GetRecentCitiesUseCase _getRecentCitiesUseCase;
  final InsertRecentCityUsecase _insertRecentCityUsecase;

  GetWeatherDaoController(
    this._getRecentCitiesUseCase,
    this._insertRecentCityUsecase,
  );

  var isLoading = false.obs;
  RxList<RecentCityEntity> recentCities = <RecentCityEntity>[].obs;

  Future<void> init() async {
    await getAllRecentCities();
  }

  Future<void> getAllRecentCities() async {
    isLoading.value = true;
    var result = await _getRecentCitiesUseCase();
    result.fold(
      (error) => null,
      (sucess) => recentCities.value = sucess,
    );
    isLoading.value = false;
  }

  Future<void> insertRecentCity(RecentCityEntity recentCity) async {
    isLoading.value = true;
    var result = await _insertRecentCityUsecase(recentCity);
    result.fold(
      (error) => null,
      (sucess) => null,
    );
    await getAllRecentCities();
    isLoading.value = false;
  }
}
