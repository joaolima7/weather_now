import 'package:flutter/material.dart';
import 'package:weather_now/presentation/components/next_predictions_list_tile.dart';

import '../../core/utils/utils.dart';

class NextPredictions extends StatelessWidget {
  final List<Map<String, dynamic>> nextPredictions;

  const NextPredictions({
    super.key,
    required this.nextPredictions,
  });

  @override
  Widget build(BuildContext context) {
    var _sizeWidth = MediaQuery.of(context).size.width;
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: nextPredictions.length,
            itemBuilder: (context, index) {
              final prediction = nextPredictions[index];

              return NextPredictionsListTile(
                icon: prediction['icon'],
                maxTemp: prediction['maxTemp'],
                minTemp: prediction['minTemp'],
                date: Utils.formatSimpleDate(prediction['date']),
              );
            },
          ),
        ],
      ),
    );
  }
}
