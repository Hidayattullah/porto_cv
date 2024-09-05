import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/entities/project_entity.dart';
import '../../cubits/project/project_cubit.dart';
import '../../cubits/project/project_state.dart';
import 'project_form.dart'; // Form untuk menambah project
import 'project_list_item.dart'; // Widget untuk item list project

class ProjectSec extends StatefulWidget {
  const ProjectSec({super.key});

  @override
  _ProjectSecState createState() => _ProjectSecState();
}

class _ProjectSecState extends State<ProjectSec> {
  late final FirebaseAuth _auth;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

    // Mendengarkan perubahan status autentikasi
    _auth.authStateChanges().listen((User? user) {
      if (!mounted) return;
      setState(() {
        _user = user;
      });

      if (user == null) {
        context.read<ProjectCubit>().fetchProjects();
      }
    });

    // Memanggil Cubit untuk mengambil daftar project
    context.read<ProjectCubit>().fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects Section'),
        actions: [
          // Hanya pengguna yang terautentikasi yang bisa menambahkan project baru
          if (_user != null)
            IconButton(
              icon: const Icon(Icons.add),
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
            ),
        ],
      ),
      body: _buildProjectBody(),
    );
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Periksa apakah daftar project kosong
          projects.isEmpty
              ? const Center(
                  child: Text(
                    'No projects found.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return ProjectListItem(
                      project: projects[index],
                    );
                  },
                ),
        ],
      ),
    );
  }
}
