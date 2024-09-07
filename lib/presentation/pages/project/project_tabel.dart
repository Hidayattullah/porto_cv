import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/auth/auth_state.dart'; // Pastikan ini benar dari cubit auth Anda
import '../../cubits/project/project_cubit.dart';
import '../../cubits/project/project_state.dart';
import '../../cubits/auth/auth_cubit.dart'; // Import AuthCubit

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
                      if (authState is AuthAuthenticated) { // Ganti dengan state yang sesuai dari AuthCubit
                        return ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/projectForm');
                          },
                          child: const Text('Add New Project'),
                        );
                      }
                      return const SizedBox.shrink(); // Tombol hilang jika tidak login
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
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // Navigasi ke halaman pengeditan
                                      Navigator.pushNamed(context, '/editProject', arguments: project);
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
