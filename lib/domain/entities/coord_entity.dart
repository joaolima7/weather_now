class CoordEntity {
  final double lon;
  final double lat;

  CoordEntity({
    required this.lon,
    required this.lat,
  });

  CoordEntity.empty()
      : lon = 0.0,
        lat = 0.0;

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
