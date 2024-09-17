class GeolocationException implements Exception {
  final String message;
  GeolocationException(this.message);

  @override
  String toString() => message;
}
