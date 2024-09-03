// File: lib/repositories/experience_repository.dart
import '../entities/experience_entity.dart';

abstract class ExperienceRepository {
  Future<void> addExperience(ExperienceEntity experience);
  Future<void> deleteExperience(String experienceId);
  Future<List<ExperienceEntity>> getExperiences();
  Future<void> updateExperience(ExperienceEntity experience);
}
