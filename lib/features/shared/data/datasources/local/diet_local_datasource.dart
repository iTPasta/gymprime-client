import 'package:gymprime/features/shared/data/datasources/local/database/diet_local_db.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DietLocalDataSource {
  Future<List<DietModel>> getMyDiets();
  Future<DietModel> getDiet(ObjectId id);
  Future<DietModel> createDiet(DietModel diet);
  Future<DietModel> updateDiet(ObjectId id, DietModel diet);
  Future<ObjectId> deleteDiet(ObjectId id);
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
  Future<DietModel> createDiet(DietModel diet) {
    dietLocalDB.insert(dietModel: diet);
    return Future.value(diet);
  }

  @override
  Future<ObjectId> deleteDiet(ObjectId id) {
    dietLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<DietModel> getDiet(ObjectId id) {
    return dietLocalDB.fetchById(id: id);
  }

  @override
  Future<List<DietModel>> getMyDiets() {
    return dietLocalDB.fetchAll();
  }

  @override
  Future<DietModel> updateDiet(ObjectId id, DietModel diet) {
    dietLocalDB.update(id: id, dietModel: diet);
    return Future.value(diet);
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
