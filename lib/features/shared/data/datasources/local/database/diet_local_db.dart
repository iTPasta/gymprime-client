import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class DietLocalDB {
  Database? database;
  String? tableName;

  static final DietLocalDB _instance = DietLocalDB._internal();

  DietLocalDB._internal();

  factory DietLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory DietLocalDB.initialize({
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
          name  TEXT,
          description TEXT,
          meals TEXT NOT NULL
        );
      ''',
    );
  }

  Future<int> insert({required DietModel dietModel}) async {
    return await database!.insert(tableName!, dietModel.toJson());
  }

  Future<List<DietModel>> fetchAll() async {
    final dietModels = await database!.query(tableName!);
    return dietModels.map((modelMap) => DietModel.fromJson(modelMap)).toList();
  }

  Future<DietModel> fetchById({required ObjectId id}) async {
    final dietModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return DietModel.fromJson(dietModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required DietModel dietModel,
  }) async {
    return await database!.update(
      tableName!,
      dietModel.toJson(),
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
