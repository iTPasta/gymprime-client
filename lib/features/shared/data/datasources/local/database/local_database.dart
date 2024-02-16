import 'dart:async';

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/aliment_local_db.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/cached_request_local_db.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/diet_local_db.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/exercise_local_db.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/meal_local_db.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/muscle_group_local_db.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/muscle_local_db.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/program_local_db.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/recipe_local_db.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/training_local_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  Database? _database;
  final String name = localDBName;

  static final LocalDatabase _instance = LocalDatabase._internal();

  LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  Future<Database> initialize() async {
    final path = await fullPath;
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<Database> get database async {
    _database ??= await initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<void> create(Database db, int version) async {
    AlimentLocalDB.initialize(
      database: _database!,
      tableName: 'aliment',
    );
    CachedRequestLocalDB.initialize(
      database: _database!,
      tableName: 'cached_request',
    );
    DietLocalDB.initialize(
      database: _database!,
      tableName: 'diet',
    );
    ExerciseLocalDB.initialize(
      database: _database!,
      tableName: 'exercise',
    );
    MealLocalDB.initialize(
      database: _database!,
      tableName: 'meal',
    );
    MuscleGroupLocalDB.initialize(
      database: _database!,
      tableName: 'muscle_group',
    );
    MuscleLocalDB.initialize(
      database: _database!,
      tableName: 'muscle',
    );
    ProgramLocalDB.initialize(
      database: _database!,
      tableName: 'program',
    );
    RecipeLocalDB.initialize(
      database: _database!,
      tableName: 'recipe',
    );
    TrainingLocalDB.initialize(
      database: _database!,
      tableName: 'training',
    );
  }
}
