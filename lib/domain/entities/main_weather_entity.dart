class MainWeatherEntity {
  final double temp;
  final double? feelsLike;
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
      temp: (map['temp'] as num).toDouble(),
      feelsLike: map['feels_like'] != null
          ? (map['feels_like'] as num).toDouble()
          : null,
      tempMin: (map['temp_min'] as num).toDouble(),
      tempMax: (map['temp_max'] as num).toDouble(),
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
    );
  }
}
