import 'package:flutter/material.dart';
import 'package:weather_now/domain/entities/weather_info.dart';

import '../components/info_item.dart';

class ContainerInfoItems extends StatelessWidget {
  WeatherInfoEntity weatherInfo;
  ContainerInfoItems({
    required this.weatherInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 82, 129, 182),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InfoItem(
              icon: Icons.water_drop, value: '${weatherInfo.main.humidity}%'),
          InfoItem(
              icon: Icons.thermostat,
              value: '${weatherInfo.main.pressure} hPa'),
          InfoItem(icon: Icons.air, value: '${weatherInfo.wind.speed} km/h'),
        ],
      ),
    );
  }
}
