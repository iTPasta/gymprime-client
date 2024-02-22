import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class AlimentLocalDB implements LocalDatabaseTable {
  Future<int> insert({required AlimentModel alimentModel});
  Future<List<AlimentModel>> fetchAll();
  Future<AlimentModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required AlimentModel alimentModel,
  });
  Future<int> delete({required ObjectId id});
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
  Future<int> insert({required AlimentModel alimentModel}) async {
    return await database.insert(tableName, alimentModel.toJson());
  }

  @override
  Future<List<AlimentModel>> fetchAll() async {
    final alimentModels = await database.query(tableName);
    return alimentModels
        .map((modelMap) => AlimentModel.fromJson(modelMap))
        .toList();
  }

  @override
  Future<AlimentModel> fetchById({required ObjectId id}) async {
    final alimentModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return AlimentModel.fromJson(alimentModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required AlimentModel alimentModel,
  }) async {
    return await database.update(
      tableName,
      alimentModel.toJson(),
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
