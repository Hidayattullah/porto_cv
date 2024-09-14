import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      print('Fetching histories...');
    }
    emit(HistoryLoading());
    try {
      final histories = await getHistory.execute();
      if (kDebugMode) {
        print('Histories fetched successfully. Total: ${histories.length}');
      }
      emit(HistoryLoaded(histories));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching histories: $e');
      }
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> addNewHistory(HistoryEntity history) async {
    if (kDebugMode) {
      print('Adding new history: ${history.companyName}');
    }
    emit(HistoryLoading());
    try {
      await addHistory.execute(history);
      if (kDebugMode) {
        print('History added successfully: ${history.companyName}');
      }
      emit(HistoryCreated());
      fetchHistories();  // Fetch ulang untuk memperbarui list
    } catch (e) {
      if (kDebugMode) {
        print('Error adding history: $e');
      }
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> updateExistingHistory(HistoryEntity history) async {
    if (kDebugMode) {
      print('Updating history: ${history.companyName}');
    }
    emit(HistoryLoading());
    try {
      await updateHistory.execute(history);
      if (kDebugMode) {
        print('History updated successfully: ${history.companyName}');
      }
      emit(HistoryUpdated());
      fetchHistories();  // Fetch ulang untuk memperbarui list
    } catch (e) {
      if (kDebugMode) {
        print('Error updating history: $e');
      }
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> deleteHistoryById(String id) async {
    if (kDebugMode) {
      print('Deleting history with ID: $id');
    }
    emit(HistoryLoading());
    try {
      await deleteHistory.execute(id);
      if (kDebugMode) {
        print('History deleted successfully: $id');
      }
      emit(HistoryDeleted());
      fetchHistories();  // Fetch ulang untuk memperbarui list
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting history: $e');
      }
      emit(HistoryError(e.toString()));
    }
  }
}
