// domain/usecases/update_history.dart
import '../../entities/history_entitiy.dart';
import '../../repositores/history_repository.dart';

class UpdateHistory {
  final HistoryRepository repository;

  UpdateHistory(this.repository);

  Future<void> execute(HistoryEntity history) async {
    return await repository.updateHistory(history);
  }
}
