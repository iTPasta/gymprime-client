import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class DietLocalDB implements LocalDatabaseTable {
  Future<int> insert({required DietModel dietModel});
  Future<List<DietModel>> fetchAll();
  Future<DietModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required DietModel dietModel,
  });
  Future<int> delete({required ObjectId id});
}

class DietLocalDBImpl implements DietLocalDB {
  late final Database database;
  final String tableName;

  DietLocalDBImpl({
    required this.tableName,
  });

  @override
  Future<void> initialize(Database database) async {
    this.database = database;
    await this.database.execute(
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

  @override
  Future<int> insert({required DietModel dietModel}) async {
    return await database.insert(tableName, dietModel.toJson());
  }

  @override
  Future<List<DietModel>> fetchAll() async {
    final dietModels = await database.query(tableName);
    return dietModels.map((modelMap) => DietModel.fromJson(modelMap)).toList();
  }

  @override
  Future<DietModel> fetchById({required ObjectId id}) async {
    final dietModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return DietModel.fromJson(dietModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required DietModel dietModel,
  }) async {
    return await database.update(
      tableName,
      dietModel.toJson(),
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
