class SysEntity {
  final String? country;
  final int? sunrise;
  final int? sunset;

  SysEntity({
    this.country,
    this.sunrise,
    this.sunset,
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
      country: map['country'] as String?,
      sunrise: map['sunrise'] as int?,
      sunset: map['sunset'] as int?,
    );
  }
}
