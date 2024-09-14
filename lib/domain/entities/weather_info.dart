import 'cloud_entity.dart';
import 'coord_entity.dart';
import 'forecast_entity.dart';
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

  // Construtor vazio
  WeatherInfoEntity.empty()
      : coord = CoordEntity(lat: 0.0, lon: 0.0),
        weather = [], // Lista vazia
        main = MainWeatherEntity(
            temp: 0.0,
            pressure: 0,
            humidity: 0,
            feelsLike: 0,
            tempMax: 0,
            tempMin: 0),
        wind = WindEntity(speed: 0.0, deg: 0),
        clouds = CloudEntity(all: 0),
        sys = SysEntity(country: '', sunrise: 0, sunset: 0),
        name = '';

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
        (map['weather'] as List<dynamic>).map<WeatherEntity>(
          (x) => WeatherEntity.fromMap(x as Map<String, dynamic>),
        ),
      ), // Corrigido para lidar com a lista de objetos weather
      main: MainWeatherEntity.fromMap(map['main'] as Map<String, dynamic>),
      wind: WindEntity.fromMap(map['wind'] as Map<String, dynamic>),
      clouds: CloudEntity.fromMap(map['clouds'] as Map<String, dynamic>),
      sys: SysEntity.fromMap(map['sys'] as Map<String, dynamic>),
      name: map['name'] as String,
    );
  }
}
