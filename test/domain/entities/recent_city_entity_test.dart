import 'package:flutter_test/flutter_test.dart';
import 'package:weather_now/domain/entities/recent_city_entity.dart';

void main() {
  test('RecentCityEntity should be created with the given cityName', () {
    const cityName = 'New York';
    final entity = RecentCityEntity(cityName: cityName);

    expect(entity.cityName, cityName);
  });
}
