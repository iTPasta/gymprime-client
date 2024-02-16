import 'package:gymprime/features/shared/data/models/cache_request_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class CachedRequestLocalDB {
  Database? database;
  String? tableName;

  static final CachedRequestLocalDB _instance =
      CachedRequestLocalDB._internal();

  CachedRequestLocalDB._internal();

  factory CachedRequestLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory CachedRequestLocalDB.initialize({
    required Database database,
    required String tableName,
  }) {
    assert(
      _instance.database == null || _instance.tableName == null,
      "Local database already initialized.",
    );

    _instance.database = database;
    _instance.tableName = tableName;
    _instance.createTable();

    return _instance;
  }

  Future<void> createTable() async {
    await database!.execute(
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

  Future<int> insert({required CachedRequestModel cachedRequestModel}) async {
    return await database!.insert(tableName!, cachedRequestModel.toJson());
  }

  Future<List<CachedRequestModel>> fetchAll() async {
    final cachedRequestModels = await database!.query(tableName!);
    return cachedRequestModels
        .map((modelMap) => CachedRequestModel.fromJson(modelMap))
        .toList();
  }

  Future<CachedRequestModel> fetchById({required ObjectId id}) async {
    final cachedRequestModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return CachedRequestModel.fromJson(cachedRequestModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required CachedRequestModel cachedRequestModel,
  }) async {
    return await database!.update(
      tableName!,
      cachedRequestModel.toJson(),
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<int> delete({required ObjectId id}) async {
    return await database!.delete(
      tableName!,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );
  }
}
