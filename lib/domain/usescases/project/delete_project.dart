// File: domain/usecases/delete_project.dart
import '../../repositores/project_repository.dart';

class DeleteProject {
  final ProjectRepository repository;

  DeleteProject(this.repository);

  Future<void> call(String projectId) async {
    return await repository.deleteProject(projectId);
  }
}
