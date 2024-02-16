import 'package:gymprime/features/shared/data/datasources/local/database/aliment_local_db.dart';
import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:objectid/objectid.dart';

abstract class AlimentLocalDataSource {
  Future<List<AlimentModel>> getMyAliments();
  Future<AlimentModel> getAliment(ObjectId id);
  Future<AlimentModel> createAliment(AlimentModel diet);
  Future<AlimentModel> updateAliment(ObjectId id, AlimentModel diet);
  Future<ObjectId> deleteAliment(ObjectId id);
}

class AlimentLocalDataSourceImpl implements AlimentLocalDataSource {
  final AlimentLocalDB _alimentLocalDB = AlimentLocalDB();

  static final AlimentLocalDataSourceImpl _instance =
      AlimentLocalDataSourceImpl._internal();

  AlimentLocalDataSourceImpl._internal();

  factory AlimentLocalDataSourceImpl() {
    return _instance;
  }

  @override
  Future<AlimentModel> createAliment(AlimentModel aliment) {
    _alimentLocalDB.insert(alimentModel: aliment);
    return Future.value(aliment);
  }

  @override
  Future<ObjectId> deleteAliment(ObjectId id) {
    _alimentLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<AlimentModel> getAliment(ObjectId id) {
    return _alimentLocalDB.fetchById(id: id);
  }

  @override
  Future<List<AlimentModel>> getMyAliments() {
    return _alimentLocalDB.fetchAll();
  }

  @override
  Future<AlimentModel> updateAliment(ObjectId id, AlimentModel aliment) {
    _alimentLocalDB.update(id: id, alimentModel: aliment);
    return Future.value(aliment);
  }
}
