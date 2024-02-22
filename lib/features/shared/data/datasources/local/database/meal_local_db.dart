import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class MealLocalDB implements LocalDatabaseTable {
  Future<int> insert({required MealModel mealModel});
  Future<List<MealModel>> fetchAll();
  Future<MealModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required MealModel mealModel,
  });
  Future<int> delete({required ObjectId id});
}

class MealLocalDBImpl implements MealLocalDB {
  late final Database database;
  final String tableName;

  MealLocalDBImpl({
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
          aliments TEXT NOT NULL,
          recipes TEXT NOT NULL
        );
      ''',
    );
  }

  @override
  Future<int> insert({required MealModel mealModel}) async {
    return await database.insert(tableName, mealModel.toJson());
  }

  @override
  Future<List<MealModel>> fetchAll() async {
    final mealModels = await database.query(tableName);
    return mealModels.map((modelMap) => MealModel.fromJson(modelMap)).toList();
  }

  @override
  Future<MealModel> fetchById({required ObjectId id}) async {
    final mealModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return MealModel.fromJson(mealModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required MealModel mealModel,
  }) async {
    return await database.update(
      tableName,
      mealModel.toJson(),
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
