// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MainWeatherEntity {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  MainWeatherEntity({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temp': temp,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'pressure': pressure,
      'humidity': humidity,
    };
  }

  factory MainWeatherEntity.fromMap(Map<String, dynamic> map) {
    return MainWeatherEntity(
      temp: map['temp'] as double,
      feelsLike: map['feelsLike'] as double,
      tempMin: map['tempMin'] as double,
      tempMax: map['tempMax'] as double,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
    );
  }
}
