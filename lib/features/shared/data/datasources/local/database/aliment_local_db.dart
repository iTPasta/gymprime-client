import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class AlimentLocalDB {
  Database? database;
  String? tableName;

  static final AlimentLocalDB _instance = AlimentLocalDB._internal();

  AlimentLocalDB._internal();

  factory AlimentLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory AlimentLocalDB.initialize({
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

  Future<int> insert({required AlimentModel alimentModel}) async {
    return await database!.insert(tableName!, alimentModel.toJson());
  }

  Future<List<AlimentModel>> fetchAll() async {
    final alimentModels = await database!.query(tableName!);
    return alimentModels
        .map((modelMap) => AlimentModel.fromJson(modelMap))
        .toList();
  }

  Future<AlimentModel> fetchById({required ObjectId id}) async {
    final alimentModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return AlimentModel.fromJson(alimentModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required AlimentModel alimentModel,
  }) async {
    return await database!.update(
      tableName!,
      alimentModel.toJson(),
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
