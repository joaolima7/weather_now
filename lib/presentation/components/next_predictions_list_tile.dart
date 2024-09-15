import 'package:flutter/material.dart';

import '../../core/utils/utils.dart';

class NextPredictionsListTile extends StatelessWidget {
  final String icon;
  final double minTemp;
  final double maxTemp;
  final String date;

  const NextPredictionsListTile({
    required this.icon,
    required this.maxTemp,
    required this.minTemp,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        Utils.getPathIconWeather(icon),
        width: 30,
        height: 30,
      ),
      title: Text(
        date,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Máx: ${maxTemp}°C - Min: ${minTemp}°C',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
