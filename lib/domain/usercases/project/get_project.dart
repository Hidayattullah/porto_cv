// File: domain/usecases/get_projects.dart
import '../../repositores/project_repository.dart';
import '../../entities/project_entity.dart';

class GetProjects {
  final ProjectRepository repository;

  GetProjects(this.repository);

  Future<List<ProjectEntity>> call() async {
    return await repository.getProjects();
  }
}
