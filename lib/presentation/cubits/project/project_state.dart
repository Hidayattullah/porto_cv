import '../../../domain/entities/project_entity.dart';

abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

// State saat projects berhasil di-fetch
class ProjectLoaded extends ProjectState {
  final List<ProjectEntity> projects;

  ProjectLoaded(this.projects);
}

// State jika ada error
class ProjectError extends ProjectState {
  final String message;

  ProjectError(this.message);
}

// State khusus saat project berhasil dibuat
class ProjectCreated extends ProjectState {}

// State khusus saat project berhasil diupdate
class ProjectUpdated extends ProjectState {}

// State khusus saat project berhasil dihapus
class ProjectDeleted extends ProjectState {}
