import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class LocalDatabaseTable {
  Future<void> initialize(Database database);
}

class LocalDatabase {
  Database? _database;
  final String name;
  final List<LocalDatabaseTable> tables;

  LocalDatabase({
    required this.name,
    required this.tables,
  });

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

  Future<void> create(Database database, int version) async {
    for (LocalDatabaseTable table in tables) {
      table.initialize(database);
    }
  }
}
