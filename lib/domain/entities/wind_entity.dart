// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WindEntity {
  final double speed;
  final int deg;

  WindEntity({
    required this.speed,
    required this.deg,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'speed': speed,
      'deg': deg,
    };
  }

  factory WindEntity.fromMap(Map<String, dynamic> map) {
    return WindEntity(
      speed: map['speed'] as double,
      deg: map['deg'] as int,
    );
  }
}
