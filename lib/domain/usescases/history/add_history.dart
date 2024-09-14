// domain/usecases/add_history.dart
import '../../entities/history_entitiy.dart';
import '../../repositores/history_repository.dart';

class AddHistory {
  final HistoryRepository repository;

  AddHistory(this.repository);

  Future<void> execute(HistoryEntity history) async {
    return await repository.addHistory(history);
  }
}
