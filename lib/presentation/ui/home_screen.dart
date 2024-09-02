import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  final List<String> savedCities = [
    'Fortaleza',
    'São Paulo',
    'Rio de Janeiro',
    'Curitiba'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000428),
        elevation: 0,
        title: Row(
          children: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                // Ação a ser tomada quando uma cidade for selecionada
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
                      fontSize: 20,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000428),
              Color(0xFF4A90E2), // Azul claro
// Azul escuro
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/weather.json', // Animação Lottie, insira o caminho correto
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    '28°',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Precipitations',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Max.: 31°   Min.: 25°',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _weatherInfoItem(Icons.water_drop, '6%'),
                        _weatherInfoItem(Icons.thermostat, '90%'),
                        _weatherInfoItem(Icons.air, '19 km/h'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _hourlyForecastItem('29°C', '15.00'),
                          _hourlyForecastItem('26°C', '16.00'),
                          _hourlyForecastItem('24°C', '17.00',
                              isHighlighted: true),
                          _hourlyForecastItem('23°C', '18.00'),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Next Forecast',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _nextForecastItem('Monday', '13°C', '10°C'),
                    _nextForecastItem('Tuesday', '17°C', '12°C'),
                    // Continue adicionando mais previsões semanais
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherInfoItem(IconData icon, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget _hourlyForecastItem(String temp, String time,
      {bool isHighlighted = false}) {
    return Container(
      width: 70,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: isHighlighted
            ? Colors.blueAccent.withOpacity(0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: isHighlighted ? Colors.blueAccent : Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            temp,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _nextForecastItem(String day, String maxTemp, String minTemp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '$maxTemp   $minTemp',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
