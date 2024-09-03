// File: lib/presentation/cubits/experience/experience_state.dart
import '../../../domain/entities/experience_entity.dart';

abstract class ExperienceState {}

class ExperienceInitial extends ExperienceState {}

class ExperienceLoading extends ExperienceState {}

class ExperienceLoaded extends ExperienceState {
  final List<ExperienceEntity> experiences;

  ExperienceLoaded(this.experiences);
}

class ExperienceError extends ExperienceState {
  final String message;

  ExperienceError(this.message);
}
