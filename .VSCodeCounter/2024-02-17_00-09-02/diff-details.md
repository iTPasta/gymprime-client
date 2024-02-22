# Diff Details

Date : 2024-02-17 00:09:02

Directory /home/kilian/gymprime-project/gymprime

Total : 43 files,  310 codes, -6 comments, 38 blanks, all 342 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/core/errors/exceptions.dart](/lib/core/errors/exceptions.dart) | Dart | 6 | 0 | 2 | 8 |
| [lib/core/errors/failures.dart](/lib/core/errors/failures.dart) | Dart | -13 | -1 | -6 | -20 |
| [lib/core/resources/data_state.dart](/lib/core/resources/data_state.dart) | Dart | -1 | 0 | -1 | -2 |
| [lib/features/shared/data/datasources/local/database/aliment_local_db.dart](/lib/features/shared/data/datasources/local/database/aliment_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/database/cached_request_local_db.dart](/lib/features/shared/data/datasources/local/database/cached_request_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/database/diet_local_db.dart](/lib/features/shared/data/datasources/local/database/diet_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/database/exercise_local_db.dart](/lib/features/shared/data/datasources/local/database/exercise_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/database/meal_local_db.dart](/lib/features/shared/data/datasources/local/database/meal_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/database/muscle_group_local_db.dart](/lib/features/shared/data/datasources/local/database/muscle_group_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/database/muscle_local_db.dart](/lib/features/shared/data/datasources/local/database/muscle_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/database/program_local_db.dart](/lib/features/shared/data/datasources/local/database/program_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/database/recipe_local_db.dart](/lib/features/shared/data/datasources/local/database/recipe_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/database/training_local_db.dart](/lib/features/shared/data/datasources/local/database/training_local_db.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/shared/data/datasources/local/muscle_group_local_datasource.dart](/lib/features/shared/data/datasources/local/muscle_group_local_datasource.dart) | Dart | 40 | 0 | 8 | 48 |
| [lib/features/shared/data/datasources/local/muscle_local_datasource.dart](/lib/features/shared/data/datasources/local/muscle_local_datasource.dart) | Dart | 36 | 0 | 8 | 44 |
| [lib/features/shared/data/datasources/local/program_local_datasource.dart](/lib/features/shared/data/datasources/local/program_local_datasource.dart) | Dart | 36 | 0 | 8 | 44 |
| [lib/features/shared/data/datasources/local/recipe_local_datasource.dart](/lib/features/shared/data/datasources/local/recipe_local_datasource.dart) | Dart | 36 | 0 | 8 | 44 |
| [lib/features/shared/data/datasources/local/training_local_datasource.dart](/lib/features/shared/data/datasources/local/training_local_datasource.dart) | Dart | 36 | 0 | 8 | 44 |
| [lib/features/shared/data/datasources/remote/diet_remote_datasource.dart](/lib/features/shared/data/datasources/remote/diet_remote_datasource.dart) | Dart | 97 | -5 | 2 | 94 |
| [lib/features/shared/data/repositories/cached_request_repo_impl.dart](/lib/features/shared/data/repositories/cached_request_repo_impl.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/features/shared/domain/entities/aliment.dart](/lib/features/shared/domain/entities/aliment.dart) | Dart | -57 | -1 | -5 | -63 |
| [lib/features/shared/domain/entities/aliment_entity.dart](/lib/features/shared/domain/entities/aliment_entity.dart) | Dart | 57 | 1 | 5 | 63 |
| [lib/features/shared/domain/entities/cached_request.dart](/lib/features/shared/domain/entities/cached_request.dart) | Dart | -34 | -1 | -5 | -40 |
| [lib/features/shared/domain/entities/cached_request_entity.dart](/lib/features/shared/domain/entities/cached_request_entity.dart) | Dart | 34 | 1 | 5 | 40 |
| [lib/features/shared/domain/entities/diet.dart](/lib/features/shared/domain/entities/diet.dart) | Dart | -28 | -1 | -5 | -34 |
| [lib/features/shared/domain/entities/diet_entity.dart](/lib/features/shared/domain/entities/diet_entity.dart) | Dart | 28 | 1 | 5 | 34 |
| [lib/features/shared/domain/entities/exercise.dart](/lib/features/shared/domain/entities/exercise.dart) | Dart | -33 | -1 | -5 | -39 |
| [lib/features/shared/domain/entities/exercise_entity.dart](/lib/features/shared/domain/entities/exercise_entity.dart) | Dart | 33 | 1 | 5 | 39 |
| [lib/features/shared/domain/entities/meal.dart](/lib/features/shared/domain/entities/meal.dart) | Dart | -32 | -1 | -6 | -39 |
| [lib/features/shared/domain/entities/meal_entity.dart](/lib/features/shared/domain/entities/meal_entity.dart) | Dart | 32 | 1 | 6 | 39 |
| [lib/features/shared/domain/entities/muscle.dart](/lib/features/shared/domain/entities/muscle.dart) | Dart | -33 | -1 | -5 | -39 |
| [lib/features/shared/domain/entities/muscle_entity.dart](/lib/features/shared/domain/entities/muscle_entity.dart) | Dart | 33 | 1 | 5 | 39 |
| [lib/features/shared/domain/entities/muscle_group.dart](/lib/features/shared/domain/entities/muscle_group.dart) | Dart | -29 | -1 | -5 | -35 |
| [lib/features/shared/domain/entities/muscle_group_entity.dart](/lib/features/shared/domain/entities/muscle_group_entity.dart) | Dart | 29 | 1 | 5 | 35 |
| [lib/features/shared/domain/entities/program.dart](/lib/features/shared/domain/entities/program.dart) | Dart | -38 | -1 | -5 | -44 |
| [lib/features/shared/domain/entities/program_entity.dart](/lib/features/shared/domain/entities/program_entity.dart) | Dart | 38 | 1 | 5 | 44 |
| [lib/features/shared/domain/entities/recipe.dart](/lib/features/shared/domain/entities/recipe.dart) | Dart | -28 | -1 | -5 | -34 |
| [lib/features/shared/domain/entities/recipe_entity.dart](/lib/features/shared/domain/entities/recipe_entity.dart) | Dart | 28 | 1 | 5 | 34 |
| [lib/features/shared/domain/entities/training.dart](/lib/features/shared/domain/entities/training.dart) | Dart | -28 | -1 | -5 | -34 |
| [lib/features/shared/domain/entities/training_entity.dart](/lib/features/shared/domain/entities/training_entity.dart) | Dart | 28 | 1 | 5 | 34 |
| [lib/injection_container.dart](/lib/injection_container.dart) | Dart | 4 | 0 | 1 | 5 |
| [macos/Flutter/GeneratedPluginRegistrant.swift](/macos/Flutter/GeneratedPluginRegistrant.swift) | Swift | 2 | 0 | 0 | 2 |
| [pubspec.yaml](/pubspec.yaml) | YAML | 2 | 0 | 0 | 2 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details