import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_now/core/utils/conts.dart';
import 'package:weather_now/presentation/ui/home_screen.dart';

class WeatherNow extends StatelessWidget {
  const WeatherNow({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        'home': (context) => HomeScreen(),
      },
    );
  }
}
