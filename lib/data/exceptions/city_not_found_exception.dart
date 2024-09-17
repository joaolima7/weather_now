class CityNotFoundException implements Exception {
  final String message;
  CityNotFoundException(this.message);

  @override
  String toString() => message;
}
