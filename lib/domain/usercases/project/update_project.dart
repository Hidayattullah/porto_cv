// File: domain/usecases/update_project.dart
import '../../repositores/project_repository.dart';
import '../../entities/project_entity.dart';

class UpdateProject {
  final ProjectRepository repository;

  UpdateProject(this.repository);

  Future<void> call(ProjectEntity project) async {
    return await repository.updateProject(project);
  }
}
