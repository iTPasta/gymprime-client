# Diff Details

Date : 2024-02-11 20:04:50

Directory /home/kilian/gymprime-project/gymprime

Total : 48 files,  1233 codes, 9 comments, 225 blanks, all 1467 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/core/constants/constants.dart](/lib/core/constants/constants.dart) | Dart | 2 | 1 | 1 | 4 |
| [lib/core/extensions/objectid_extension.dart](/lib/core/extensions/objectid_extension.dart) | Dart | 6 | 0 | 2 | 8 |
| [lib/core/resources/myobjectid.dart](/lib/core/resources/myobjectid.dart) | Dart | -6 | 0 | -2 | -8 |
| [lib/core/resources/object_entity.dart](/lib/core/resources/object_entity.dart) | Dart | -1 | 0 | -1 | -2 |
| [lib/features/shared/data/datasources/local/aliment_local_datasource.dart](/lib/features/shared/data/datasources/local/aliment_local_datasource.dart) | Dart | 42 | 0 | 11 | 53 |
| [lib/features/shared/data/datasources/local/cached_request_datasource.dart](/lib/features/shared/data/datasources/local/cached_request_datasource.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/features/shared/data/datasources/local/cached_request_local_datasource.dart](/lib/features/shared/data/datasources/local/cached_request_local_datasource.dart) | Dart | 32 | 0 | 9 | 41 |
| [lib/features/shared/data/datasources/local/database/aliment_local_db.dart](/lib/features/shared/data/datasources/local/database/aliment_local_db.dart) | Dart | 83 | 0 | 15 | 98 |
| [lib/features/shared/data/datasources/local/database/cached_request_local_db.dart](/lib/features/shared/data/datasources/local/database/cached_request_local_db.dart) | Dart | 77 | 0 | 15 | 92 |
| [lib/features/shared/data/datasources/local/database/diet_local_db.dart](/lib/features/shared/data/datasources/local/database/diet_local_db.dart) | Dart | 73 | 0 | 15 | 88 |
| [lib/features/shared/data/datasources/local/database/exercise_local_db.dart](/lib/features/shared/data/datasources/local/database/exercise_local_db.dart) | Dart | 76 | 0 | 15 | 91 |
| [lib/features/shared/data/datasources/local/database/local_database.dart](/lib/features/shared/data/datasources/local/database/local_database.dart) | Dart | 83 | 0 | 10 | 93 |
| [lib/features/shared/data/datasources/local/database/meal_local_db.dart](/lib/features/shared/data/datasources/local/database/meal_local_db.dart) | Dart | 74 | 0 | 15 | 89 |
| [lib/features/shared/data/datasources/local/database/muscle_group_local_db.dart](/lib/features/shared/data/datasources/local/database/muscle_group_local_db.dart) | Dart | 75 | 0 | 15 | 90 |
| [lib/features/shared/data/datasources/local/database/muscle_local_db.dart](/lib/features/shared/data/datasources/local/database/muscle_local_db.dart) | Dart | 76 | 0 | 15 | 91 |
| [lib/features/shared/data/datasources/local/database/program_local_db.dart](/lib/features/shared/data/datasources/local/database/program_local_db.dart) | Dart | 77 | 0 | 15 | 92 |
| [lib/features/shared/data/datasources/local/database/recipe_local_db.dart](/lib/features/shared/data/datasources/local/database/recipe_local_db.dart) | Dart | 75 | 0 | 15 | 90 |
| [lib/features/shared/data/datasources/local/database/training_local_db.dart](/lib/features/shared/data/datasources/local/database/training_local_db.dart) | Dart | 75 | 0 | 15 | 90 |
| [lib/features/shared/data/datasources/local/diet_local_datasource.dart](/lib/features/shared/data/datasources/local/diet_local_datasource.dart) | Dart | 27 | 0 | 6 | 33 |
| [lib/features/shared/data/datasources/local/exercise_local_datasource.dart](/lib/features/shared/data/datasources/local/exercise_local_datasource.dart) | Dart | 36 | 0 | 8 | 44 |
| [lib/features/shared/data/datasources/local/meal_local_datasource.dart](/lib/features/shared/data/datasources/local/meal_local_datasource.dart) | Dart | 36 | 0 | 8 | 44 |
| [lib/features/shared/data/datasources/remote/diet_remote_datasource.dart](/lib/features/shared/data/datasources/remote/diet_remote_datasource.dart) | Dart | 22 | 5 | 5 | 32 |
| [lib/features/shared/data/models/aliment_model.dart](/lib/features/shared/data/models/aliment_model.dart) | Dart | 15 | 0 | 1 | 16 |
| [lib/features/shared/data/models/cache_request_model.dart](/lib/features/shared/data/models/cache_request_model.dart) | Dart | 2 | 0 | 0 | 2 |
| [lib/features/shared/data/models/diet_model.dart](/lib/features/shared/data/models/diet_model.dart) | Dart | 6 | 0 | 1 | 7 |
| [lib/features/shared/data/models/exercise_model.dart](/lib/features/shared/data/models/exercise_model.dart) | Dart | 8 | 0 | 1 | 9 |
| [lib/features/shared/data/models/meal_model.dart](/lib/features/shared/data/models/meal_model.dart) | Dart | 7 | 0 | 1 | 8 |
| [lib/features/shared/data/models/muscle_group_model.dart](/lib/features/shared/data/models/muscle_group_model.dart) | Dart | 6 | 0 | 1 | 7 |
| [lib/features/shared/data/models/muscle_model.dart](/lib/features/shared/data/models/muscle_model.dart) | Dart | 9 | 0 | 1 | 10 |
| [lib/features/shared/data/models/program_model.dart](/lib/features/shared/data/models/program_model.dart) | Dart | 10 | 0 | 1 | 11 |
| [lib/features/shared/data/models/recipe_model.dart](/lib/features/shared/data/models/recipe_model.dart) | Dart | 6 | 0 | 1 | 7 |
| [lib/features/shared/data/models/training_model.dart](/lib/features/shared/data/models/training_model.dart) | Dart | 6 | 0 | 1 | 7 |
| [lib/features/shared/data/repositories/cached_request_repo_impl.dart](/lib/features/shared/data/repositories/cached_request_repo_impl.dart) | Dart | -2 | 0 | 0 | -2 |
| [lib/features/shared/data/repositories/diet_repository_impl.dart](/lib/features/shared/data/repositories/diet_repository_impl.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/features/shared/domain/entities/aliment.dart](/lib/features/shared/domain/entities/aliment.dart) | Dart | 20 | 0 | 0 | 20 |
| [lib/features/shared/domain/entities/cached_request.dart](/lib/features/shared/domain/entities/cached_request.dart) | Dart | 6 | 0 | 0 | 6 |
| [lib/features/shared/domain/entities/diet.dart](/lib/features/shared/domain/entities/diet.dart) | Dart | 11 | 0 | 1 | 12 |
| [lib/features/shared/domain/entities/exercise.dart](/lib/features/shared/domain/entities/exercise.dart) | Dart | 13 | 0 | 0 | 13 |
| [lib/features/shared/domain/entities/meal.dart](/lib/features/shared/domain/entities/meal.dart) | Dart | 13 | 0 | 2 | 15 |
| [lib/features/shared/domain/entities/muscle.dart](/lib/features/shared/domain/entities/muscle.dart) | Dart | 13 | 0 | 0 | 13 |
| [lib/features/shared/domain/entities/muscle_group.dart](/lib/features/shared/domain/entities/muscle_group.dart) | Dart | 11 | 0 | 0 | 11 |
| [lib/features/shared/domain/entities/program.dart](/lib/features/shared/domain/entities/program.dart) | Dart | 8 | 0 | 1 | 9 |
| [lib/features/shared/domain/entities/recipe.dart](/lib/features/shared/domain/entities/recipe.dart) | Dart | 11 | 0 | 1 | 12 |
| [lib/features/shared/domain/entities/training.dart](/lib/features/shared/domain/entities/training.dart) | Dart | 11 | 0 | 1 | 12 |
| [lib/features/shared/domain/usecases/diet_usecases.dart](/lib/features/shared/domain/usecases/diet_usecases.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/injection_container.dart](/lib/injection_container.dart) | Dart | 8 | 3 | 5 | 16 |
| [lib/main.dart](/lib/main.dart) | Dart | 1 | 0 | 0 | 1 |
| [pubspec.yaml](/pubspec.yaml) | YAML | 2 | 0 | 0 | 2 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details