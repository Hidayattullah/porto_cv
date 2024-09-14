// domain/repositories/history_repository.dart
import '../entities/history_entitiy.dart';

abstract class HistoryRepository {
  Future<void> addHistory(HistoryEntity history);
  Future<List<HistoryEntity>> getHistory();
  Future<void> updateHistory(HistoryEntity history);
  Future<void> deleteHistory(String id);
}
