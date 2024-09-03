import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_now/core/inject/inject.dart';
import 'package:weather_now/weather_now.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Inject.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const WeatherNow());
  });
}
