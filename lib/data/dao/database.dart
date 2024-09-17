import 'dart:async';
import 'package:floor/floor.dart';
import 'package:weather_now/data/dao/daos/recent_city_dao.dart';
import 'floor_entities/recent_city_floor_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [RecentCityFloorEntity])
abstract class RecentCitiesDatabase extends FloorDatabase {
  RecentCityDao get recentCityDao;
}
