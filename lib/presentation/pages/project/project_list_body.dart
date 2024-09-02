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

          return LayoutBuilder(
            builder: (context, constraints) {
              // Check the width of the screen to adjust the table layout
              bool isSmallScreen = constraints.maxWidth < 600;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                  ),
                  child: DataTable(
                    columnSpacing: isSmallScreen ? 10 : 20,
                    columns: const [
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Start Date')),
                      DataColumn(label: Text('End Date')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: projectState.projects.map((project) {
                      return DataRow(cells: [
                        DataCell(Text(
                          project.title,
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                        )),
                        DataCell(Text(
                          project.description,
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                        )),
                        DataCell(Text(
                          project.startDate.toString(),
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                        )),
                        DataCell(Text(
                          project.endDate.toString(),
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                        )),
                        DataCell(ProjectListItem(project: project)),
                      ]);
                    }).toList(),
                  ),
                ),
              );
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
