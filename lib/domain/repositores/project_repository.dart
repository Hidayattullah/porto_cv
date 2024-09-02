// File: domain/repositories/project_repository.dart
import '../entities/project_entity.dart';

abstract class ProjectRepository {
  Future<void> addProject(ProjectEntity project);
  Future<void> updateProject(ProjectEntity project);
  Future<void> deleteProject(String projectId);
  Future<List<ProjectEntity>> getProjects();
}
