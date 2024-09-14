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
      // Konversi entity menjadi model
      final historyModel = HistoryModel(
        id: history.id,
        companyName: history.companyName,
        jobTitle: history.jobTitle,
        applyDate: history.applyDate,
        source: history.source,
        status: history.status,
        link: history.link,
      );
      // Panggil dataSource untuk menambah history
      await dataSource.addHistory(historyModel);
      if (kDebugMode) {
        print('History added successfully: ${history.companyName}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding history: $e');
      }
      throw Exception("Failed to add history");
    }
  }

  @override
  Future<List<HistoryEntity>> getHistory() async {
    try {
      // Ambil list dari dataSource
      final historyModels = await dataSource.getHistory();
      if (kDebugMode) {
        print('Histories retrieved successfully.');
      }
      // Konversi model menjadi entity
      return historyModels.map((historyModel) {
        return HistoryEntity(
          id: historyModel.id,
          companyName: historyModel.companyName,
          jobTitle: historyModel.jobTitle,
          applyDate: historyModel.applyDate,
          source: historyModel.source,
          status: historyModel.status,
          link: historyModel.link,
        );
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving histories: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> updateHistory(HistoryEntity history) async {
    try {
      // Konversi entity menjadi model
      final historyModel = HistoryModel(
        id: history.id,
        companyName: history.companyName,
        jobTitle: history.jobTitle,
        applyDate: history.applyDate,
        source: history.source,
        status: history.status,
        link: history.link,
      );
      // Panggil dataSource untuk update history
      await dataSource.updateHistory(historyModel);
      if (kDebugMode) {
        print('History updated successfully: ${history.companyName}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating history: $e');
      }
      throw Exception("Failed to update history");
    }
  }

  @override
  Future<void> deleteHistory(String id) async {
    try {
      // Panggil dataSource untuk menghapus history
      await dataSource.deleteHistory(id);
      if (kDebugMode) {
        print('History deleted successfully: $id');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting history: $e');
      }
      throw Exception("Failed to delete history");
    }
  }
}
