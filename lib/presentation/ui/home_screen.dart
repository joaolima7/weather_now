import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_now/presentation/controllers/controller_api.dart';
import 'package:weather_now/presentation/widgets/app_bar.dart';
import 'package:weather_now/presentation/widgets/container_info_items.dart';
import 'package:weather_now/presentation/widgets/next_predictions.dart';
import 'package:weather_now/presentation/widgets/today_predictions.dart';
import '../../core/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = GetIt.I<GetWeatherApiController>();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    var _sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), child: AppBarApp()),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF000428),
                  Color(0xFF4A90E2),
                ],
              ),
            ),
            child: Center(
                child: Lottie.asset('assets/animations/weather loading.json')),
          );
        }

        final weatherInfo = _controller.weatherInfo.value;

        return Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF000428),
                Color(0xFF4A90E2),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/animations/weather.json',
                  width: _sizeWidth * .4,
                  height: _sizeWidth * .4,
                ),
                Text(
                  '${weatherInfo.main.temp}°',
                  style: TextStyle(
                    fontSize: _sizeWidth * .18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  weatherInfo.weather.isNotEmpty
                      ? Utils.capitalize(weatherInfo.weather.first.description)
                      : 'Sem dados',
                  style: TextStyle(
                    fontSize: _sizeWidth * .05,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Max.: ${weatherInfo.main.tempMax}°   Min.: ${weatherInfo.main.tempMin}°',
                  style: TextStyle(
                    fontSize: _sizeWidth * .05,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ContainerInfoItems(
                    weatherInfo: weatherInfo,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  child: TodayPredictions(
                    todayForecasts: _controller.getTodayForecasts(),
                    highlightedIndex: _controller.findClosestForecastIndex(
                      _controller.getTodayForecasts(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: NextPredictions(
                      nextPredictions: _controller.getNextPredictions()),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      }),
    );
  }
}
