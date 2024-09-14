// data/repositories/history_repository_impl.dart
import '../../domain/entities/history_entitiy.dart';
import '../../domain/repositores/history_repository.dart';
import '../datasources/history_datasource.dart';
import '../model/history/history_model.dart';


class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource dataSource;

  HistoryRepositoryImpl(this.dataSource);

  @override
  Future<void> addHistory(HistoryEntity history) async {
    final historyModel = HistoryModel(
      id: history.id,
      companyName: history.companyName,
      jobTitle: history.jobTitle,
      applyDate: history.applyDate,
      source: history.source,
      status: history.status,
      notes: history.notes,
    );
    return await dataSource.addHistory(historyModel);
  }

  @override
  Future<List<HistoryEntity>> getHistories() async {
    final historyModels = await dataSource.getHistories();
    return historyModels;
  }

  @override
  Future<void> updateHistory(HistoryEntity history) async {
    final historyModel = HistoryModel(
      id: history.id,
      companyName: history.companyName,
      jobTitle: history.jobTitle,
      applyDate: history.applyDate,
      source: history.source,
      status: history.status,
      notes: history.notes,
    );
    return await dataSource.updateHistory(historyModel);
  }

  @override
  Future<void> deleteHistory(String id) async {
    return await dataSource.deleteHistory(id);
  }
}
