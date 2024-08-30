// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SysEntity {
  final String country;
  final int sunrise;
  final int sunset;

  SysEntity({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  factory SysEntity.fromMap(Map<String, dynamic> map) {
    return SysEntity(
      country: map['country'] as String,
      sunrise: map['sunrise'] as int,
      sunset: map['sunset'] as int,
    );
  }
}
