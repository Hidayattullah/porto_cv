abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final List<String> projects;

  ProjectLoaded(this.projects);
}
