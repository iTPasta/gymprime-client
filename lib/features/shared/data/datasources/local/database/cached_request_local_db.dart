import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/request_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class CachedRequestLocalDB implements LocalDatabaseTable {
  Future<int> insert({required RequestModel cachedRequestModel});
  Future<List<RequestModel>> fetchAll();
  Future<RequestModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required RequestModel cachedRequestModel,
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
  Future<int> insert({required RequestModel cachedRequestModel}) async {
    return await database.insert(tableName, cachedRequestModel.toJson());
  }

  @override
  Future<List<RequestModel>> fetchAll() async {
    final cachedRequestModels = await database.query(tableName);
    return cachedRequestModels
        .map((modelMap) => RequestModel.fromJson(modelMap))
        .toList();
  }

  @override
  Future<RequestModel> fetchById({required ObjectId id}) async {
    final cachedRequestModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return RequestModel.fromJson(cachedRequestModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required RequestModel cachedRequestModel,
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
