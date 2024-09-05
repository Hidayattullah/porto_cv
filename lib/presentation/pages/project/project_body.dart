import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/project_entity.dart';
import '../../cubits/project/project_cubit.dart';
import '../../cubits/project/project_state.dart';
import 'project_list_item.dart';

class ProjectListBody extends StatelessWidget {
  const ProjectListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (state is ProjectLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProjectLoaded) {
          final List<ProjectEntity> projects = state.projects;

          if (projects.isEmpty) {
            return const Center(child: Text('No projects available.'));
          }

          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ProjectListItem(project: project);
            },
          );
        } else if (state is ProjectError) {
          return Center(child: Text('Failed to load projects: ${state.message}'));
        } else {
          return const Center(child: Text('No data to display.'));
        }
      },
    );
  }
}
