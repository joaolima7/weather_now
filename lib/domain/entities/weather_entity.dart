// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherEntity {
  final String main;
  final String description;
  final String icon;

  WeatherEntity({
    required this.main,
    required this.description,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory WeatherEntity.fromMap(Map<String, dynamic> map) {
    return WeatherEntity(
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
    );
  }
}
