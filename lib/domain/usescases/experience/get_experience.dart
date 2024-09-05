// File: lib/domain/usecases/experience/get_experience.dart
import '../../entities/experience_entity.dart';
import '../../repositores/experience_repository.dart';

class GetExperiences {
  final ExperienceRepository repository;

  GetExperiences(this.repository);

  Future<List<ExperienceEntity>> call() {
    return repository.getExperiences();
  }
}