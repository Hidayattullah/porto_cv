// domain/usecases/get_history.dart
import '../../entities/history_entitiy.dart';
import '../../repositores/history_repository.dart';

class GetHistory {
  final HistoryRepository repository;

  GetHistory(this.repository);

  Future<List<HistoryEntity>> execute() async {
    return await repository.getHistory();
  }
}
