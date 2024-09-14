import 'package:equatable/equatable.dart';
import '../../../domain/entities/history_entitiy.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

// Initial state when cubit is created
class HistoryInitial extends HistoryState {}

// Loading state when fetching data or processing an operation
class HistoryLoading extends HistoryState {}

// State when histories are successfully loaded
class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> histories;

  const HistoryLoaded(this.histories);

  @override
  List<Object?> get props => [histories];
}

// Error state with a message
class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
