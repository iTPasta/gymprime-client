import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/aliment_local_db.dart';
import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AlimentLocalDataSource {
  Future<List<AlimentModel>> getMyAliments();
  Future<AlimentModel> getAliment(ObjectId id);
  Future<void> createAliment(AlimentModel diet);
  Future<void> updateAliment(ObjectId? id, AlimentModel diet);
  Future<void> deleteAliment(ObjectId id);
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
  Future<List<AlimentModel>> getMyAliments() async {
    return await alimentLocalDB.fetchAll();
  }

  @override
  Future<AlimentModel> getAliment(ObjectId id) async {
    final List<AlimentModel> aliments = await alimentLocalDB.fetchById(id);
    if (aliments.isEmpty) {
      throw NoRowAffectedException();
    } else if (1 < aliments.length) {
      throw MultipleRowsAffectedException();
    } else {
      return aliments.first;
    }
  }

  @override
  Future<void> createAliment(AlimentModel aliment) async {
    final int id = await alimentLocalDB.insert(aliment);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> updateAliment(ObjectId? id, AlimentModel aliment) async {
    final int rowsUpdated =
        await alimentLocalDB.update(id ?? aliment.id, aliment);
    if (rowsUpdated == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsUpdated) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> deleteAliment(ObjectId id) async {
    final int rowDeleted = await alimentLocalDB.delete(id);
    if (rowDeleted == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowDeleted) {
      throw MultipleRowsAffectedException();
    }
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
