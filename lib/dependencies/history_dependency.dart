// core/dependencies/history_dependency.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import '../../data/datasources/history_datasource.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../domain/repositores/history_repository.dart';
import '../domain/usescases/history/add_history.dart';
import '../domain/usescases/history/delete_history.dart';
import '../domain/usescases/history/get_history.dart';
import '../domain/usescases/history/update_history.dart';


final sl = GetIt.instance;

void initHistoryDependencies() {
  // Data Source
  sl.registerLazySingleton<HistoryDataSource>(
    () => HistoryDataSourceImpl(FirebaseFirestore.instance),
  );

  // Repository
  sl.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => AddHistory(sl()));
  sl.registerLazySingleton(() => DeleteHistory(sl()));
  sl.registerLazySingleton(() => GetHistory(sl()));
  sl.registerLazySingleton(() => UpdateHistory(sl()));
}
