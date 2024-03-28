import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class AlimentLocalDB implements LocalDatabaseTable {
  Future<int> insert(AlimentModel aliment);
  Future<List<AlimentModel>> fetchAll();
  Future<List<AlimentModel>> fetchById(ObjectId id);
  Future<int> update(ObjectId id, AlimentModel aliment);
  Future<int> delete(ObjectId id);
}

class AlimentLocalDBImpl implements AlimentLocalDB {
  late final Database database;
  final String tableName;

  AlimentLocalDBImpl({
    required this.tableName,
  });

  @override
  Future<void> initialize(Database database) async {
    this.database = database;
    await this.database.execute(
      '''
        CREATE TABLE IF NOT EXISTS $tableName (
          id  TEXT PRIMARY KEY NOT NULL,
          barCode  TEXT,
          name  TEXT,
          ciqualCode INTEGER,
          allergens TEXT,
          brands TEXT,
          countryCode TEXT,
          ecoscoreGrade TEXT,
          ecoscoreScore INTEGER,
          imageUrl TEXT,
          nutriscoreGrade TEXT,
          nutriscoreScore INTEGER
        );
      ''',
    );
  }

  @override
  Future<int> insert(AlimentModel aliment) async {
    return await database.insert(tableName, aliment.toJson());
  }

  @override
  Future<List<AlimentModel>> fetchAll() async {
    final alimentsMaps = await database.query(tableName);
    return AlimentModel.fromJsonToList(alimentsMaps);
  }

  @override
  Future<List<AlimentModel>> fetchById(ObjectId id) async {
    final alimentsMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return AlimentModel.fromJsonToList(alimentsMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    AlimentModel aliment,
  ) async {
    return await database.update(
      tableName,
      aliment.toJson(),
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
