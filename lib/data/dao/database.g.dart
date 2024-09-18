// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $RecentCitiesDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $RecentCitiesDatabaseBuilderContract addMigrations(
      List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $RecentCitiesDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<RecentCitiesDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorRecentCitiesDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $RecentCitiesDatabaseBuilderContract databaseBuilder(String name) =>
      _$RecentCitiesDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $RecentCitiesDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$RecentCitiesDatabaseBuilder(null);
}

class _$RecentCitiesDatabaseBuilder
    implements $RecentCitiesDatabaseBuilderContract {
  _$RecentCitiesDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $RecentCitiesDatabaseBuilderContract addMigrations(
      List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $RecentCitiesDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<RecentCitiesDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$RecentCitiesDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$RecentCitiesDatabase extends RecentCitiesDatabase {
  _$RecentCitiesDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RecentCityDao? _recentCityDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `recent_cities` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `cityName` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RecentCityDao get recentCityDao {
    return _recentCityDaoInstance ??= _$RecentCityDao(database, changeListener);
  }
}

class _$RecentCityDao extends RecentCityDao {
  _$RecentCityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _recentCityFloorEntityInsertionAdapter = InsertionAdapter(
            database,
            'recent_cities',
            (RecentCityFloorEntity item) =>
                <String, Object?>{'id': item.id, 'cityName': item.cityName});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RecentCityFloorEntity>
      _recentCityFloorEntityInsertionAdapter;

  @override
  Future<List<RecentCityFloorEntity>> getAllRecentCities() async {
    return _queryAdapter.queryList(
        'SELECT * FROM recent_cities ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => RecentCityFloorEntity(
            id: row['id'] as int?, cityName: row['cityName'] as String));
  }

  @override
  Future<RecentCityFloorEntity?> findCityByName(String name) async {
    return _queryAdapter.query(
        'SELECT * FROM recent_cities WHERE cityName = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => RecentCityFloorEntity(
            id: row['id'] as int?, cityName: row['cityName'] as String),
        arguments: [name]);
  }

  @override
  Future<void> deleteOldestRecentCity() async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM recent_cities WHERE id = (SELECT id FROM recent_cities ORDER BY id ASC LIMIT 1)');
  }

  @override
  Future<void> insertRecentCity(RecentCityFloorEntity recent_city) async {
    await _recentCityFloorEntityInsertionAdapter.insert(
        recent_city, OnConflictStrategy.replace);
  }
}
