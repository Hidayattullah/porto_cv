// File: presentation/pages/project_list_page/project_list_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/project_entity.dart';
import '../../cubits/project/project_cubit.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';
import '../../widgets/forms/project_form.dart';

class ProjectListItem extends StatelessWidget {
  final ProjectEntity project;

  const ProjectListItem({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(project.title),
        subtitle: Text(project.description),
        trailing: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is AuthAuthenticated) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ProjectForm(
                            project: project,
                            onSubmit: (updatedProject) {
                              context.read<ProjectCubit>().updateExistingProject(updatedProject);
                            },
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<ProjectCubit>().removeProject(project.id);
                    },
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        onTap: () {
          // Logika untuk mengarahkan ke detail proyek atau link
        },
      ),
    );
  }
}
