import 'package:gymprime/features/shared/data/datasources/local/database/aliment_local_db.dart';
import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AlimentLocalDataSource {
  Future<List<AlimentModel>> getMyAliments();
  Future<AlimentModel> getAliment(ObjectId id);
  Future<AlimentModel> createAliment(AlimentModel diet);
  Future<AlimentModel> updateAliment(ObjectId id, AlimentModel diet);
  Future<ObjectId> deleteAliment(ObjectId id);
  int? getAlimentsLastUpdate();
  void setAlimentsLastUpdate(int alimentsLastUpdate);
}

class AlimentLocalDataSourceImpl implements AlimentLocalDataSource {
  final AlimentLocalDB alimentLocalDB;
  final SharedPreferences sharedPreferences;

  AlimentLocalDataSourceImpl({
    required this.alimentLocalDB,
    required this.sharedPreferences,
  });

  @override
  Future<AlimentModel> createAliment(AlimentModel aliment) {
    alimentLocalDB.insert(alimentModel: aliment);
    return Future.value(aliment);
  }

  @override
  Future<ObjectId> deleteAliment(ObjectId id) {
    alimentLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<AlimentModel> getAliment(ObjectId id) {
    return alimentLocalDB.fetchById(id: id);
  }

  @override
  Future<List<AlimentModel>> getMyAliments() {
    return alimentLocalDB.fetchAll();
  }

  @override
  Future<AlimentModel> updateAliment(ObjectId id, AlimentModel aliment) {
    alimentLocalDB.update(id: id, alimentModel: aliment);
    return Future.value(aliment);
  }

  @override
  int? getAlimentsLastUpdate() {
    return sharedPreferences.getInt("alimentsLastUpdate");
  }

  @override
  void setAlimentsLastUpdate(int alimentsLastUpdate) {
    sharedPreferences.setInt("alimentsLastUpdate", alimentsLastUpdate);
  }
}
