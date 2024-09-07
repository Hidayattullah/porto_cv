import 'package:flutter/foundation.dart'; // Import untuk kDebugMode
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/project_entity.dart';
import '../../../domain/usescases/project/add_project.dart';
import '../../../domain/usescases/project/delete_project.dart';
import '../../../domain/usescases/project/get_project.dart';
import '../../../domain/usescases/project/update_project.dart';
import 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final AddProject addProject;
  final UpdateProject updateProject;
  final DeleteProject deleteProject;
  final GetProjects getProjects;

  ProjectCubit({
    required this.addProject,
    required this.updateProject,
    required this.deleteProject,
    required this.getProjects,
  }) : super(ProjectInitial());

  Future<void> fetchProjects() async {
    if (kDebugMode) {
      print('Fetching projects...');
    }
    emit(ProjectLoading());
    try {
      final projects = await getProjects();
      if (kDebugMode) {
        print('Projects fetched successfully. Total: ${projects.length}');
      }
      emit(ProjectLoaded(projects));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching projects: $e');
      }
      emit(ProjectError(e.toString()));
    }
  }

  Future<void> createProject(ProjectEntity project) async {
    if (kDebugMode) {
      print('Creating project: ${project.title}');
    }
    emit(ProjectLoading());
    try {
      await addProject(project);
      if (kDebugMode) {
        print('Project created successfully: ${project.title}');
      }
      // Emit state untuk project yang berhasil ditambahkan
      emit(ProjectCreated());
      // Fetch ulang project list setelah berhasil menambah project
      fetchProjects();
    } catch (e) {
      if (kDebugMode) {
        print('Error creating project: $e');
      }
      emit(ProjectError(e.toString()));
    }
  }

  Future<void> updateExistingProject(ProjectEntity project) async {
    if (kDebugMode) {
      print('Updating project: ${project.title}');
    }
    emit(ProjectLoading());
    try {
      await updateProject(project);
      if (kDebugMode) {
        print('Project updated successfully: ${project.title}');
      }
      // Emit state untuk project yang berhasil diupdate
      emit(ProjectUpdated());
      // Fetch ulang project list setelah berhasil mengupdate project
      fetchProjects();
    } catch (e) {
      if (kDebugMode) {
        print('Error updating project: $e');
      }
      emit(ProjectError(e.toString()));
    }
  }

  Future<void> removeProject(String projectId) async {
    if (kDebugMode) {
      print('Removing project: $projectId');
    }
    emit(ProjectLoading());
    try {
      await deleteProject(projectId);
      if (kDebugMode) {
        print('Project removed successfully: $projectId');
      }
      // Emit state untuk project yang berhasil dihapus
      emit(ProjectDeleted());
      // Fetch ulang project list setelah berhasil menghapus project
      fetchProjects();
    } catch (e) {
      if (kDebugMode) {
        print('Error removing project: $e');
      }
      emit(ProjectError(e.toString()));
    }
  }
}
