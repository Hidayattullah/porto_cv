import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/auth/auth_state.dart'; // AuthCubit import
import '../../cubits/project/project_cubit.dart';
import '../../cubits/project/project_state.dart';
import '../../cubits/auth/auth_cubit.dart'; // Import AuthCubit
import 'project_form.dart'; // Form untuk menambah project
import 'project_update.dart'; // Import halaman update

class ProjectTable extends StatelessWidget {
  const ProjectTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects Table'),
      ),
      body: BlocBuilder<ProjectCubit, ProjectState>(
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
                children: [
                  // Cek apakah pengguna sudah login menggunakan AuthCubit
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, authState) {
                      if (authState is AuthAuthenticated) {
                        return ElevatedButton(
                          onPressed: () {
                            // Menampilkan form dialog untuk menambahkan project baru
                            showDialog(
                              context: context,
                              builder: (context) => ProjectForm(
                                onAddProject: (newProject) {
                                  // Logika untuk menambahkan project baru menggunakan Cubit
                                  context.read<ProjectCubit>().createProject(newProject);
                                },
                              ),
                            );
                          },
                          child: const Text('Add New Project'),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Expanded(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Title')),
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('Year')),
                        DataColumn(label: Text('Built With')),
                        DataColumn(label: Text('Made At')),
                        DataColumn(label: Text('Link')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: projects.map((project) {
                        return DataRow(
                          cells: [
                            DataCell(Text(project.title)),
                            DataCell(Text(project.description)),
                            DataCell(Text(project.yearMade)),
                            DataCell(Text(project.builtWith)),
                            DataCell(Text(project.madeAt)),
                            DataCell(Text(project.link)),
                            DataCell(
                              Row(
                                children: [
                                  // Tombol hanya muncul ketika user login
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, authState) {
                                      if (authState is AuthAuthenticated) {
                                        return Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                // Navigasi ke halaman pengeditan
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ProjectListUpdate(project: project),
                                                  ),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                // Hapus project
                                                context.read<ProjectCubit>().removeProject(project.id);
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProjectError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
