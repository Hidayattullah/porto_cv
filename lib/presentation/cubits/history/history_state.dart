// presentation/cubits/history/history_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/history_entitiy.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> histories;

  const HistoryLoaded(this.histories);

  @override
  List<Object?> get props => [histories];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}

class HistoryAdded extends HistoryState {}

class HistoryUpdated extends HistoryState {}

class HistoryDeleted extends HistoryState {}
