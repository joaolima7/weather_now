import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_now/domain/entities/forecast_entity.dart';
import '../../core/utils/utils.dart';
import '../components/forecast_day_item.dart';

class TodayPredictions extends StatelessWidget {
  final List<ForecastEntity> todayForecasts;
  final int highlightedIndex;

  const TodayPredictions({
    super.key,
    required this.todayForecasts,
    required this.highlightedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 82, 129, 182),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Hoje',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              Text(
                Utils.capitalize(Utils.formatedNowDate()),
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: todayForecasts.length,
              itemBuilder: (context, index) {
                final forecast = todayForecasts[index];

                final temp = '${forecast.main.temp}°C';
                final time = DateFormat('HH:mm').format(
                  DateTime.parse(forecast.dtTxt!),
                );

                return ForecastDayItem(
                  temp: temp,
                  time: time,
                  iconPath: Utils.getPathIconWeather(forecast.weather[0].icon),
                  isHighlighted: index == highlightedIndex,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
