import 'package:flutter/foundation.dart';
import '../../domain/entities/history_entitiy.dart';
import '../../domain/repositores/history_repository.dart';
import '../datasources/history_datasource.dart';
import '../model/history/history_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource dataSource;

  HistoryRepositoryImpl(this.dataSource);

  @override
  Future<void> addHistory(HistoryEntity history) async {
    try {
      final historyModel = HistoryModel(
        id: history.id,
        companyName: history.companyName,
        jobTitle: history.jobTitle,
        applyDate: history.applyDate,
        source: history.source,
        status: history.status,
        link: history.link,
      );
      await dataSource.addHistory(historyModel);
      if (kDebugMode) {
        print('History added successfully: ${history.companyName}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding history: $e');
      }
    }
  }

  @override
  Future<List<HistoryEntity>> getHistories() async {
    try {
      final historyModels = await dataSource.getHistories();
      if (kDebugMode) {
        print('Histories retrieved successfully.');
      }
      return historyModels;
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving histories: $e');
      }
      rethrow; // rethrow if necessary to propagate the error
    }
  }

  @override
  Future<void> updateHistory(HistoryEntity history) async {
    try {
      final historyModel = HistoryModel(
        id: history.id,
        companyName: history.companyName,
        jobTitle: history.jobTitle,
        applyDate: history.applyDate,
        source: history.source,
        status: history.status,
        link: history.link,
      );
      await dataSource.updateHistory(historyModel);
      if (kDebugMode) {
        print('History updated successfully: ${history.companyName}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating history: $e');
      }
    }
  }

  @override
  Future<void> deleteHistory(String id) async {
    try {
      await dataSource.deleteHistory(id);
      if (kDebugMode) {
        print('History deleted successfully: $id');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting history: $e');
      }
    }
  }
}
