// File: domain/usecases/add_project.dart
import '../../repositores/project_repository.dart';
import '../../entities/project_entity.dart';

class AddProject {
  final ProjectRepository repository;

  AddProject(this.repository);

  Future<void> call(ProjectEntity project) async {
    return await repository.addProject(project);
  }
}
