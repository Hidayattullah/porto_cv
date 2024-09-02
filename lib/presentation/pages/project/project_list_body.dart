// File: presentation/pages/project_list_page/project_list_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/project/project_cubit.dart';
import '../../cubits/project/project_state.dart';
import 'project_list_item.dart';

class ProjectListBody extends StatelessWidget {
  const ProjectListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, projectState) {
        if (projectState is ProjectLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (projectState is ProjectLoaded) {
          if (projectState.projects.isEmpty) {
            return const Center(child: Text('No projects found.'));
          }
          return ListView.builder(
            itemCount: projectState.projects.length,
            itemBuilder: (context, index) {
              final project = projectState.projects[index];
              return ProjectListItem(project: project);
            },
          );
        } else if (projectState is ProjectError) {
          return Center(child: Text(projectState.message));
        }
        return const Center(child: Text('No projects found.'));
      },
    );
  }
}
