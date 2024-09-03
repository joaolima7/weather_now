import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_now/domain/usecases/get_weather_info_by_city_usecase/get_weather_info_by_city_usecase.dart';
import 'package:weather_now/presentation/components/forecast_day_item.dart';
import 'package:weather_now/presentation/components/info_item.dart';

class HomeScreen extends StatelessWidget {
  final GetWeatherInfoByCityUseCase _getWeatherInfoByCityUseCase =
      GetIt.I.get<GetWeatherInfoByCityUseCase>();
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
  Widget build(BuildContext context) {
    var _sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000428),
        elevation: 0,
        title: Row(
          children: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                print('Cidade selecionada: $value');
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
                  SizedBox(width: 8),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/weather.json',
                    width: _sizeWidth * .4,
                    height: _sizeWidth * .4,
                  ),
                  Text(
                    '28°',
                    style: TextStyle(
                      fontSize: _sizeWidth * .18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Chuvas Intensas',
                    style: TextStyle(
                      fontSize: _sizeWidth * .05,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Max.: 31°   Min.: 25°',
                    style: TextStyle(
                      fontSize: _sizeWidth * .05,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 20),
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
                          InfoItem(icon: Icons.water_drop, value: '6%'),
                          InfoItem(icon: Icons.thermostat, value: '90%'),
                          InfoItem(icon: Icons.air, value: '19 kmh'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                      SizedBox(height: 15),
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
                      SizedBox(height: 15),
                      Column(
                        children: nextPrevisions
                            .map((e) => Text('${e['day']}'))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
