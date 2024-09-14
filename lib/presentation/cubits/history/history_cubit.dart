// presentation/cubits/history/history_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/history_entitiy.dart';
import '../../../domain/usescases/history/add_history.dart';
import '../../../domain/usescases/history/delete_history.dart';
import '../../../domain/usescases/history/get_history.dart';
import '../../../domain/usescases/history/update_history.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistory getHistory;
  final AddHistory addHistory;
  final UpdateHistory updateHistory;
  final DeleteHistory deleteHistory;

  HistoryCubit({
    required this.getHistory,
    required this.addHistory,
    required this.updateHistory,
    required this.deleteHistory,
  }) : super(HistoryInitial());

  Future<void> fetchHistories() async {
    try {
      emit(HistoryLoading());
      final histories = await getHistory.execute();
      emit(HistoryLoaded(histories));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> addNewHistory(HistoryEntity history) async {
    try {
      emit(HistoryLoading());
      await addHistory.execute(history);
      emit(HistoryAdded());
      await fetchHistories(); // Refresh the list
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> updateExistingHistory(HistoryEntity history) async {
    try {
      emit(HistoryLoading());
      await updateHistory.execute(history);
      emit(HistoryUpdated());
      await fetchHistories(); // Refresh the list
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> deleteHistoryById(String id) async {
    try {
      emit(HistoryLoading());
      await deleteHistory.execute(id);
      emit(HistoryDeleted());
      await fetchHistories(); // Refresh the list
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
