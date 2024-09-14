// core/dependencies/history_dependencies.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/history_datasource.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../domain/usescases/history/add_history.dart';
import '../domain/usescases/history/delete_history.dart';
import '../domain/usescases/history/get_history.dart';
import '../domain/usescases/history/update_history.dart';
import '../presentation/cubits/history/history_cubit.dart';

// Function to provide dependencies for HistoryCubit
List<BlocProvider> provideHistoryDependencies() {
  final firestore = FirebaseFirestore.instance;

  // Data Source
  final historyDataSource = HistoryDataSourceImpl(firestore);

  // Repository
  final historyRepository = HistoryRepositoryImpl(historyDataSource);

  // Use Cases
  final addHistoryUseCase = AddHistory(historyRepository);
  final deleteHistoryUseCase = DeleteHistory(historyRepository);
  final getHistoryUseCase = GetHistory(historyRepository);
  final updateHistoryUseCase = UpdateHistory(historyRepository);

  return [
    BlocProvider<HistoryCubit>(
      create: (context) => HistoryCubit(
        addHistory: addHistoryUseCase,
        deleteHistory: deleteHistoryUseCase,
        getHistory: getHistoryUseCase,
        updateHistory: updateHistoryUseCase,
      ),
    ),
  ];
}
