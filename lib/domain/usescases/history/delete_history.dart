// domain/usecases/delete_history.dart
import '../../repositores/history_repository.dart';

class DeleteHistory {
  final HistoryRepository repository;

  DeleteHistory(this.repository);

  Future<void> execute(String id) async {
    return await repository.deleteHistory(id);
  }
}
