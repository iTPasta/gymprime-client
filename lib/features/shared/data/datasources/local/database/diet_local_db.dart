import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class DietLocalDB implements LocalDatabaseTable {
  Future<int> insert(DietModel diet);
  Future<List<DietModel>> fetchAll();
  Future<List<DietModel>> fetchById(ObjectId id);
  Future<int> update(
    ObjectId id,
    DietModel diet,
  );
  Future<int> delete(ObjectId id);
  Future<int> erase();
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
  Future<int> insert(DietModel diet) async {
    return await database.insert(tableName, diet.toJson());
  }

  @override
  Future<List<DietModel>> fetchAll() async {
    final dietsMaps = await database.query(tableName);
    return DietModel.fromJsonToList(dietsMaps);
  }

  @override
  Future<List<DietModel>> fetchById(ObjectId id) async {
    final dietsMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return DietModel.fromJsonToList(dietsMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    DietModel diet,
  ) async {
    return await database.update(
      tableName,
      diet.toJson(),
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

  @override
  Future<int> erase() async {
    return await database.delete(
      tableName,
      where: null,
    );
  }
}
