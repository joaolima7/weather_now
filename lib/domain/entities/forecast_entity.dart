import 'cloud_entity.dart';
import 'main_weather_entity.dart';
import 'sys_entity.dart';
import 'weather_entity.dart';
import 'wind_entity.dart';

class ForecastEntity {
  final int dt;
  final MainWeatherEntity main;
  final List<WeatherEntity> weather;
  final CloudEntity clouds;
  final WindEntity wind;
  final SysEntity? sys;
  final String? dtTxt;

  ForecastEntity({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    this.sys,
    this.dtTxt,
  });

  factory ForecastEntity.fromMap(Map<String, dynamic> map) {
    return ForecastEntity(
      dt: map['dt'] as int,
      main: MainWeatherEntity.fromMap(map['main'] as Map<String, dynamic>),
      weather: List<WeatherEntity>.from(
        (map['weather'] as List<dynamic>).map(
          (x) => WeatherEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      clouds: CloudEntity.fromMap(map['clouds'] as Map<String, dynamic>),
      wind: WindEntity.fromMap(map['wind'] as Map<String, dynamic>),
      sys: map.containsKey('sys')
          ? SysEntity.fromMap(map['sys'] as Map<String, dynamic>)
          : null,
      dtTxt: map['dt_txt'] as String?, // Permitir valores nulos
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dt': dt,
      'main': main.toMap(),
      'weather': weather.map((x) => x.toMap()).toList(),
      'clouds': clouds.toMap(),
      'wind': wind.toMap(),
      'sys': sys?.toMap(),
      'dt_txt': dtTxt,
    };
  }
}
