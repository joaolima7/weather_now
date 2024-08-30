// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'cloud_entity.dart';
import 'coord_entity.dart';
import 'main_weather_entity.dart';
import 'sys_entity.dart';
import 'weather_entity.dart';
import 'wind_entity.dart';

class WeatherInfoEntity {
  final CoordEntity coord;
  final List<WeatherEntity> weather;
  final MainWeatherEntity main;
  final WindEntity wind;
  final CloudEntity clouds;
  final SysEntity sys;
  final String name;

  WeatherInfoEntity({
    required this.coord,
    required this.weather,
    required this.main,
    required this.wind,
    required this.clouds,
    required this.sys,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coord': coord.toMap(),
      'weather': weather.map((x) => x.toMap()).toList(),
      'main': main.toMap(),
      'wind': wind.toMap(),
      'clouds': clouds.toMap(),
      'sys': sys.toMap(),
      'name': name,
    };
  }

  factory WeatherInfoEntity.fromMap(Map<String, dynamic> map) {
    return WeatherInfoEntity(
      coord: CoordEntity.fromMap(map['coord'] as Map<String, dynamic>),
      weather: List<WeatherEntity>.from(
        (map['weather'] as List<int>).map<WeatherEntity>(
          (x) => WeatherEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      main: MainWeatherEntity.fromMap(map['main'] as Map<String, dynamic>),
      wind: WindEntity.fromMap(map['wind'] as Map<String, dynamic>),
      clouds: CloudEntity.fromMap(map['clouds'] as Map<String, dynamic>),
      sys: SysEntity.fromMap(map['sys'] as Map<String, dynamic>),
      name: map['name'] as String,
    );
  }
}
