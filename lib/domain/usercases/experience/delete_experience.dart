// File: lib/domain/usecases/experience/delete_experience.dart
import '../../repositores/experience_repository.dart';

class DeleteExperience {
  final ExperienceRepository repository;

  DeleteExperience(this.repository);

  Future<void> call(String experienceId) {
    return repository.deleteExperience(experienceId);
  }
}