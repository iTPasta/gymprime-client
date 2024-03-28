import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/diet_local_db.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DietLocalDataSource {
  Future<List<DietModel>> getMyDiets();
  Future<DietModel> getDiet(ObjectId id);
  Future<void> createDiet(DietModel diet);
  Future<void> updateDiet(ObjectId id, DietModel diet);
  Future<void> deleteDiet(ObjectId id);
  Future<void> setMyDiets(List<DietModel> diets);
  int? getDietsLastUpdate();
  void setDietsLastUpdate(int dietsLastUpdate);
}

class DietLocalDataSourceImpl implements DietLocalDataSource {
  final DietLocalDB dietLocalDB;
  final SharedPreferences sharedPreferences;

  DietLocalDataSourceImpl({
    required this.dietLocalDB,
    required this.sharedPreferences,
  });

  @override
  Future<List<DietModel>> getMyDiets() async {
    return await dietLocalDB.fetchAll();
  }

  @override
  Future<DietModel> getDiet(ObjectId id) async {
    final List<DietModel> diets = await dietLocalDB.fetchById(id);
    if (diets.isEmpty) {
      throw NoRowAffectedException();
    } else if (1 < diets.length) {
      throw MultipleRowsAffectedException();
    } else {
      return diets.first;
    }
  }

  @override
  Future<void> createDiet(DietModel diet) async {
    final int id = await dietLocalDB.insert(diet);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> updateDiet(ObjectId id, DietModel diet) async {
    final int rowsUpdated = await dietLocalDB.update(id, diet);
    if (rowsUpdated == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsUpdated) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> deleteDiet(ObjectId id) async {
    final int rowsDeleted = await dietLocalDB.delete(id);
    if (rowsDeleted == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsDeleted) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> setMyDiets(List<DietModel> diets) async {
    final int rowsDeleted = await dietLocalDB.erase();
    if (rowsDeleted == 0) {
      throw NoRowAffectedException();
    }
    for (DietModel diet in diets) {
      final int rowsInserted = await dietLocalDB.insert(diet);
      if (rowsInserted == 0) {
        throw NoRowInsertedException();
      }
    }
  }

  @override
  int? getDietsLastUpdate() {
    return sharedPreferences.getInt("dietsLastUpdate");
  }

  @override
  void setDietsLastUpdate(int dietsLastUpdate) {
    sharedPreferences.setInt(
      "dietsLastUpdate",
      dietsLastUpdate,
    );
  }
}
