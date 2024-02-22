import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/cache_request_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class CachedRequestLocalDB implements LocalDatabaseTable {
  Future<int> insert({required CachedRequestModel cachedRequestModel});
  Future<List<CachedRequestModel>> fetchAll();
  Future<CachedRequestModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required CachedRequestModel cachedRequestModel,
  });
  Future<int> delete({required ObjectId id});
}

class CachedRequestLocalDBImpl implements CachedRequestLocalDB {
  late final Database database;
  final String tableName;

  CachedRequestLocalDBImpl({
    required this.tableName,
  });

  @override
  Future<void> initialize(Database database) async {
    this.database = database;
    await this.database.execute(
      '''
        CREATE TABLE IF NOT EXISTS $tableName (
          id  TEXT PRIMARY KEY NOT NULL,
          requestType  TEXT NOT NULL,
          headers TEXT NOT NULL,
          body TEXT NOT NULL,
          date INTEGER NOT NULL
        );
      ''',
    );
  }

  @override
  Future<int> insert({required CachedRequestModel cachedRequestModel}) async {
    return await database.insert(tableName, cachedRequestModel.toJson());
  }

  @override
  Future<List<CachedRequestModel>> fetchAll() async {
    final cachedRequestModels = await database.query(tableName);
    return cachedRequestModels
        .map((modelMap) => CachedRequestModel.fromJson(modelMap))
        .toList();
  }

  @override
  Future<CachedRequestModel> fetchById({required ObjectId id}) async {
    final cachedRequestModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return CachedRequestModel.fromJson(cachedRequestModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required CachedRequestModel cachedRequestModel,
  }) async {
    return await database.update(
      tableName,
      cachedRequestModel.toJson(),
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  @override
  Future<int> delete({required ObjectId id}) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );
  }
}
