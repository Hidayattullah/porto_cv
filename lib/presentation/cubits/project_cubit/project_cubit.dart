import 'package:flutter_bloc/flutter_bloc.dart';
import 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectInitial());

  void loadProjects() {
    // Simulate data fetching
    emit(ProjectLoaded([
      'Project 1: A cool project',
      'Project 2: Another cool project'
    ]));
  }
}
