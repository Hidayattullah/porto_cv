// File: lib/domain/usecases/experience/update_experience.dart
import '../../entities/experience_entity.dart';
import '../../repositores/experience_repository.dart';

class UpdateExperience {
  final ExperienceRepository repository;

  UpdateExperience(this.repository);

  Future<void> call(ExperienceEntity experience) {
    return repository.updateExperience(experience);
  }
}