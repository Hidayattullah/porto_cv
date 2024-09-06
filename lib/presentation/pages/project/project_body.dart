import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/project_entity.dart';
import '../../cubits/project/project_cubit.dart';
import '../../cubits/project/project_state.dart';
import 'project_list_item.dart';

class ProjectBody extends StatelessWidget {
  const ProjectBody({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildProjectBody();
  }

  Widget _buildProjectBody() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (state is ProjectLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProjectLoaded) {
          return _buildProjectSection(state.projects);
        } else if (state is ProjectError) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        } else {
          return const Center(
            child: Text('No projects available.'),
          );
        }
      },
    );
  }

  Widget _buildProjectSection(List<ProjectEntity> projects) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: projects.isEmpty
              ? [
                  const Center(
                    child: Text(
                      'No projects found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ]
              : projects.map((project) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white, // Warna latar belakang item
                      borderRadius: BorderRadius.circular(5.0), // Border radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Warna bayangan
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(2, 4), // Posisi bayangan
                        ),
                      ],
                    ),
                    child: ProjectListItem(
                      project: project,
                    ),
                  );
                }).toList(),
        ),
      ),
    );
  }
}
