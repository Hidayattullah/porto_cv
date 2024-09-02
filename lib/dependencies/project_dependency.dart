// File: lib/dependencies/project_dependencies.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/repositories/project_repository_impl.dart';
import '../domain/usercases/project/add_project.dart';
import '../domain/usercases/project/delete_project.dart';
import '../domain/usercases/project/get_project.dart';
import '../domain/usercases/project/update_project.dart';
import '../presentation/cubits/project/project_cubit.dart';

// Fungsi untuk menyediakan dependencies ProjectCubit
List<BlocProvider> provideProjectDependencies() {
  final firestore = FirebaseFirestore.instance;
  final projectRepository = ProjectRepositoryImpl(firestore); // Menggunakan implementasi konkret
  final addProjectUseCase = AddProject(projectRepository);
  final updateProjectUseCase = UpdateProject(projectRepository);
  final deleteProjectUseCase = DeleteProject(projectRepository);
  final getProjectsUseCase = GetProjects(projectRepository);

  return [
    BlocProvider<ProjectCubit>(
      create: (context) => ProjectCubit(
        addProject: addProjectUseCase,
        updateProject: updateProjectUseCase,
        deleteProject: deleteProjectUseCase,
        getProjects: getProjectsUseCase,
      ),
    ),
  ];
}
