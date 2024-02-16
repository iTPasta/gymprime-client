import 'package:gymprime/features/shared/data/datasources/local/database/diet_local_db.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:objectid/objectid.dart';

abstract class DietLocalDataSource {
  Future<List<DietModel>> getMyDiets();
  Future<DietModel> getDiet(ObjectId id);
  Future<DietModel> createDiet(DietModel diet);
  Future<DietModel> updateDiet(ObjectId id, DietModel diet);
  Future<ObjectId> deleteDiet(ObjectId id);
}

class DietLocalDataSourceImpl implements DietLocalDataSource {
  final DietLocalDB _dietLocalDB = DietLocalDB();

  @override
  Future<DietModel> createDiet(DietModel diet) {
    _dietLocalDB.insert(dietModel: diet);
    return Future.value(diet);
  }

  @override
  Future<ObjectId> deleteDiet(ObjectId id) {
    _dietLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<DietModel> getDiet(ObjectId id) {
    return _dietLocalDB.fetchById(id: id);
  }

  @override
  Future<List<DietModel>> getMyDiets() {
    return _dietLocalDB.fetchAll();
  }

  @override
  Future<DietModel> updateDiet(ObjectId id, DietModel diet) {
    _dietLocalDB.update(id: id, dietModel: diet);
    return Future.value(diet);
  }
}
