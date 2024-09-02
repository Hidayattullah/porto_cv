// File: presentation/pages/project_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/project/project_cubit.dart';
import '../../cubits/project/project_state.dart';
import '../../cubits/auth/auth_cubit.dart'; // Import AuthCubit
import '../../cubits/auth/auth_state.dart'; // Import AuthState
import '../../widgets/forms/project_form.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data proyek saat halaman diinisialisasi
    context.read<ProjectCubit>().fetchProjects();
  }

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
                builder: (context, projectState) {
                  if (projectState is ProjectLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (projectState is ProjectLoaded) {
                    return projectState.projects.isEmpty
                        ? const Center(child: Text('No projects found.'))
                        : ListView.builder(
                            itemCount: projectState.projects.length,
                            itemBuilder: (context, index) {
                              final project = projectState.projects[index];
                              return Card(
                                child: ListTile(
                                  title: Text(project.title),
                                  subtitle: Text(project.description),
                                  trailing: BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, authState) {
                                      // Periksa jika authState adalah AuthAuthenticated
                                      if (authState is AuthAuthenticated) {
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                // Aksi update
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return ProjectForm(
                                                      project: project, // Mengirim proyek yang ada ke form
                                                      onSubmit: (updatedProject) {
                                                        // Panggil cubit untuk mengupdate proyek
                                                        context
                                                            .read<ProjectCubit>()
                                                            .updateExistingProject(updatedProject);
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                // Aksi delete
                                                context
                                                    .read<ProjectCubit>()
                                                    .removeProject(project.id);
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                      // Jika tidak login, tidak menampilkan apa-apa
                                      return const SizedBox.shrink(); // Kembali widget kosong
                                    },
                                  ),
                                  onTap: () {
                                    // Logika untuk mengarahkan ke detail proyek atau link
                                  },
                                ),
                              );
                            },
                          );
                  } else if (projectState is ProjectError) {
                    return Center(child: Text(projectState.message));
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
          return const SizedBox.shrink(); // Kembali widget kosong
        },
      ),
    );
  }
}
