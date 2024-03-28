import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/action_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class ActionLocalDB implements LocalDatabaseTable {
  Future<int> insert(ActionModel action);
  Future<List<ActionModel>> fetchAll();
  Future<List<ActionModel>> fetchById(ObjectId id);
  Future<int> update(
    ObjectId id,
    ActionModel action,
  );
  Future<int> delete(ObjectId id);
}

class ActionLocalDBImpl implements ActionLocalDB {
  late final Database database;
  final String tableName;

  ActionLocalDBImpl({
    required this.tableName,
  });

  @override
  Future<void> initialize(Database database) async {
    this.database = database;
    await this.database.execute(
      '''
        CREATE TABLE IF NOT EXISTS $tableName (
          id  TEXT PRIMARY KEY NOT NULL,
          actionType  TEXT NOT NULL,
          modelType TEXT NOT NULL,
          objectId  TEXT NOT NULL,
          date INT NOT NULL
        );
      ''',
    );
  }

  @override
  Future<int> insert(ActionModel action) async {
    return await database.insert(tableName, action.toJson());
  }

  @override
  Future<List<ActionModel>> fetchAll() async {
    final cachedActionsMaps = await database.query(
      tableName,
      orderBy: "date ASC",
    );
    return ActionModel.fromJsonToList(cachedActionsMaps);
  }

  @override
  Future<List<ActionModel>> fetchById(ObjectId id) async {
    final cachedActionsMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return ActionModel.fromJsonToList(cachedActionsMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    ActionModel action,
  ) async {
    return await database.update(
      tableName,
      action.toJson(),
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
