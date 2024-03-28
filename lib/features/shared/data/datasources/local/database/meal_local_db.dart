import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class MealLocalDB implements LocalDatabaseTable {
  Future<int> insert(MealModel meal);
  Future<List<MealModel>> fetchAll();
  Future<List<MealModel>> fetchById(ObjectId id);
  Future<int> update(
    ObjectId id,
    MealModel meal,
  );
  Future<int> delete(ObjectId id);
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
  Future<int> insert(MealModel meal) async {
    return await database.insert(tableName, meal.toJson());
  }

  @override
  Future<List<MealModel>> fetchAll() async {
    final mealMaps = await database.query(tableName);
    return MealModel.fromJsonToList(mealMaps);
  }

  @override
  Future<List<MealModel>> fetchById(ObjectId id) async {
    final mealsMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return MealModel.fromJsonToList(mealsMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    MealModel meal,
  ) async {
    return await database.update(
      tableName,
      meal.toJson(),
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  @override
  Future<int> delete(ObjectId id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );
  }
}
