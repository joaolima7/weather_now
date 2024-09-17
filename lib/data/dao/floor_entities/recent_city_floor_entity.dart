import 'package:floor/floor.dart';

import '../../../domain/entities/recent_city_entity.dart';

@Entity(tableName: 'recent_cities')
class RecentCityFloorEntity extends RecentCityEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  RecentCityFloorEntity({
    this.id,
    required super.cityName,
  });
}
