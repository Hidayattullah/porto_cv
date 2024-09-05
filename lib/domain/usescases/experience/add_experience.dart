// File: lib/domain/usecases/experience/add_experience.dart
import '../../entities/experience_entity.dart';
import '../../repositores/experience_repository.dart';

class AddExperience {
  final ExperienceRepository repository;

  AddExperience(this.repository);

  Future<void> call(ExperienceEntity experience) {
    return repository.addExperience(experience);
  }
}