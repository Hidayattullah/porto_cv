import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/project/project_cubit.dart';
import '../../cubits/project/project_state.dart';
import 'project_list_item.dart';

class ProjectBody extends StatelessWidget {
  const ProjectBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (state is ProjectLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProjectLoaded) {
          final projects = state.projects;
          if (projects.isEmpty) {
            return const Center(child: Text('No projects available.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure button stretches to full width
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: ProjectListItem(project: projects[index]), // No BoxDecoration here
                      );
                    },
                  ),
                ),
                // Button to navigate to the table view, positioned at the bottom
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/projectTable');
                  },
                  child: const Text('View Detailed Projects Table'),
                ),
              ],
            ),
          );
        } else if (state is ProjectError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
