import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../cubits/project/project_cubit.dart';
import 'project_form.dart'; // Form untuk menambah project
import 'project_body.dart'; // Menggunakan ProjectBody

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
      body: const ProjectBody(), // Memanggil ProjectBody di sini
    );
  }
}
