// File: presentation/pages/project_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/project/project_cubit.dart';
import '../../cubits/project/project_state.dart';
import '../../cubits/auth/auth_cubit.dart'; // Import AuthCubit
import '../../cubits/auth/auth_state.dart'; // Import AuthState
import '../../widgets/forms/project_form.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Projects'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'All Projects',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  if (state is ProjectLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProjectLoaded) {
                    // Menampilkan data meskipun hanya ada satu entri
                    return state.projects.isEmpty 
                        ? const Center(child: Text('No projects found.'))
                        : ListView.builder(
                            itemCount: state.projects.length,
                            itemBuilder: (context, index) {
                              final project = state.projects[index];
                              return Card(
                                child: ListTile(
                                  title: Text(project.title),
                                  subtitle: Text(project.description),
                                  trailing: Text('${project.startDate.year}'), // Tahun
                                  onTap: () {
                                    // Logika untuk mengarahkan ke detail proyek atau link
                                  },
                                ),
                              );
                            },
                          );
                  } else if (state is ProjectError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('No projects found.'));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState is AuthAuthenticated) {
            // Tampilkan FloatingActionButton hanya jika pengguna sudah login
            return FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ProjectForm(
                      onSubmit: (newProject) {
                        // Panggil cubit untuk menambahkan proyek baru
                        context.read<ProjectCubit>().createProject(newProject);
                      },
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            );
          }
          // Jika tidak login, jangan tampilkan FloatingActionButton
          return Container();
        },
      ),
    );
  }
}
