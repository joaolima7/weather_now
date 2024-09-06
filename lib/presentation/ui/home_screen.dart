import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_now/presentation/components/forecast_day_item.dart';
import 'package:weather_now/presentation/components/info_item.dart';
import 'package:weather_now/presentation/controllers/get_controller.dart';

import '../../core/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Obtém o controlador via GetIt
  final _controller = GetIt.I<GetWeatherController>();

  final List<String> savedCities = [
    'Fortaleza',
    'São Paulo',
    'Rio de Janeiro',
    'Curitiba'
  ];

  final List<Map<String, String>> nextPrevisions = [
    {'day': 'Segunda', 'max': '10', 'min': '9'}
  ];

  @override
  void initState() {
    super.initState();
    // Verifica as permissões e tenta buscar a localização
    _determinePositionAndFetchWeather();
  }

  // Método para solicitar permissões de localização e buscar o clima
  Future<void> _determinePositionAndFetchWeather() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error',
          'Serviço de localização desabilitado. Habilite para continuar.');
      return;
    }

    // Verifica as permissões de localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Erro', 'Permissão de localização negada.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Erro', 'Habilite a localização nas configurações.');
      return;
    }

    // Busca a localização e atualiza o clima
    await _controller.getWeatherByLocation();
  }

  @override
  Widget build(BuildContext context) {
    var _sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000428),
        title: Row(
          children: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                _controller.getWeatherByCityName(
                    value); // Chama o método do controlador
              },
              itemBuilder: (BuildContext context) {
                return savedCities.map((String city) {
                  return PopupMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Fortaleza',
                    style: TextStyle(
                      fontSize: _sizeWidth * .05,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Ação de pesquisa
            },
          ),
        ],
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
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
              Obx(() {
                // Exibe o carregamento enquanto o dado é obtido
                if (_controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final weatherInfo = _controller.weatherInfo.value;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          ? Utils.capitalize(
                              weatherInfo.weather.first.description)
                          : 'Sem dados',
                      style: TextStyle(
                        fontSize: _sizeWidth * .05,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 8),
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 82, 129, 182),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InfoItem(
                                icon: Icons.water_drop,
                                value: '${weatherInfo.main.humidity}%'),
                            InfoItem(
                                icon: Icons.thermostat,
                                value: '${weatherInfo.main.pressure} hPa'),
                            InfoItem(
                                icon: Icons.air,
                                value: '${weatherInfo.wind.speed} km/h'),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 82, 129, 182),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Hoje',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          Text(
                            'Set, 9',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 130,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ForecastDayItem(temp: '29°C', time: '15.00'),
                            ForecastDayItem(temp: '26°C', time: '16.00'),
                            ForecastDayItem(
                                temp: '24°C',
                                time: '17.00',
                                isHighlighted: true),
                            ForecastDayItem(temp: '23°C', time: '18.00'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 82, 129, 182),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Próximas Previsões',
                              style: TextStyle(
                                  fontSize: _sizeWidth * .048,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          Icon(
                            Icons.calendar_month,
                            size: _sizeWidth * .06,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        children: nextPrevisions
                            .map((e) => Text('${e['day']}'))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Teste'))
            ],
          ),
        ),
      ),
    );
  }
}
