import 'package:flutter/material.dart';

class ForecastDayItem extends StatelessWidget {
  final bool isHighlighted;
  final String temp;
  final String time;

  const ForecastDayItem({
    super.key,
    this.isHighlighted = false,
    required this.temp,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isHighlighted ? Colors.white24 : Colors.transparent),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            temp,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Image.asset(
              'assets/images/storm.png',
              width: 35,
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
