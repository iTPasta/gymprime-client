import 'package:get_it/get_it.dart';
import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/datasources/local/aliment_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/local/cached_request_local_datasource.dart';
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
import 'package:gymprime/features/shared/data/datasources/local/diet_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/local/exercise_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/local/meal_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/local/muscle_group_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/local/muscle_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/local/program_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/local/recipe_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/local/training_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // HTTP Client
  sl.registerSingleton<http.Client>(http.Client());

  // Shared preferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Local database
  sl.registerSingleton<AlimentLocalDB>(
    AlimentLocalDBImpl(tableName: 'aliment'),
  );
  sl.registerSingleton<CachedRequestLocalDB>(
    CachedRequestLocalDBImpl(tableName: 'cachedRequest'),
  );
  sl.registerSingleton<DietLocalDB>(
    DietLocalDBImpl(tableName: 'diet'),
  );
  sl.registerSingleton<ExerciseLocalDB>(
    ExerciseLocalDBImpl(tableName: 'exercise'),
  );
  sl.registerSingleton<MealLocalDB>(
    MealLocalDBImpl(tableName: 'meal'),
  );
  sl.registerSingleton<MuscleGroupLocalDB>(
    MuscleGroupLocalDBImpl(tableName: 'muscleGroup'),
  );
  sl.registerSingleton<MuscleLocalDB>(
    MuscleLocalDBImpl(tableName: 'muscle'),
  );
  sl.registerSingleton<ProgramLocalDB>(
    ProgramLocalDBImpl(tableName: 'program'),
  );
  sl.registerSingleton<RecipeLocalDB>(
    RecipeLocalDBImpl(tableName: 'recipe'),
  );
  sl.registerSingleton<TrainingLocalDB>(
    TrainingLocalDBImpl(tableName: 'training'),
  );

  final LocalDatabase localDatabase = LocalDatabase(
    name: 'gymprime.db',
    tables: [
      sl<AlimentLocalDB>(),
      sl<CachedRequestLocalDB>(),
      sl<DietLocalDB>(),
      sl<ExerciseLocalDB>(),
      sl<MealLocalDB>(),
      sl<MuscleGroupLocalDB>(),
      sl<MuscleLocalDB>(),
      sl<ProgramLocalDB>(),
      sl<RecipeLocalDB>(),
      sl<TrainingLocalDB>(),
    ],
  );
  localDatabase.initialize();
  sl.registerSingleton<LocalDatabase>(localDatabase);

  // Local datasource
  sl.registerSingleton<AlimentLocalDataSource>(AlimentLocalDataSourceImpl(
    alimentLocalDB: sl<AlimentLocalDB>(),
    sharedPreferences: sl<SharedPreferences>(),
  ));
  sl.registerSingleton<CachedRequestLocalDataSource>(
      CachedRequestLocalDataSourceImpl(
    cachedRequestLocalDB: sl<CachedRequestLocalDB>(),
  ));
  sl.registerSingleton<DietLocalDataSource>(DietLocalDataSourceImpl(
    dietLocalDB: sl<DietLocalDB>(),
    sharedPreferences: sl<SharedPreferences>(),
  ));
  sl.registerSingleton<ExerciseLocalDataSource>(ExerciseLocalDataSourceImpl(
    exerciseLocalDB: sl<ExerciseLocalDB>(),
    sharedPreferences: sl<SharedPreferences>(),
  ));
  sl.registerSingleton<MealLocalDataSource>(MealLocalDataSourceImpl(
    mealLocalDB: sl<MealLocalDB>(),
    sharedPreferences: sl<SharedPreferences>(),
  ));
  sl.registerSingleton<MuscleGroupLocalDataSource>(
      MuscleGroupLocalDataSourceImpl(
    muscleGroupLocalDB: sl<MuscleGroupLocalDB>(),
    sharedPreferences: sl<SharedPreferences>(),
  ));
  sl.registerSingleton<MuscleLocalDataSource>(MuscleLocalDataSourceImpl(
    muscleLocalDB: sl<MuscleLocalDB>(),
    sharedPreferences: sl<SharedPreferences>(),
  ));
  sl.registerSingleton<ProgramLocalDataSource>(ProgramLocalDataSourceImpl(
    programLocalDB: sl<ProgramLocalDB>(),
    sharedPreferences: sl<SharedPreferences>(),
  ));
  sl.registerSingleton<RecipeLocalDataSource>(RecipeLocalDataSourceImpl(
    recipeLocalDB: sl<RecipeLocalDB>(),
    sharedPreferences: sl<SharedPreferences>(),
  ));
  sl.registerSingleton<TrainingLocalDataSource>(TrainingLocalDataSourceImpl(
    trainingLocalDB: sl<TrainingLocalDB>(),
    sharedPreferences: sl<SharedPreferences>(),
  ));

  // Remote datasource

  // Repositories
}
