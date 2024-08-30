// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CoordEntity {
  final double lon;
  final double lat;

  CoordEntity({
    required this.lon,
    required this.lat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lon': lon,
      'lat': lat,
    };
  }

  factory CoordEntity.fromMap(Map<String, dynamic> map) {
    return CoordEntity(
      lon: map['lon'] as double,
      lat: map['lat'] as double,
    );
  }
}
