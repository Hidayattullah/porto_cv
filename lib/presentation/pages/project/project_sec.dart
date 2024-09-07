import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/project/project_cubit.dart';
import 'project_body.dart'; // Menggunakan ProjectBody

class ProjectSec extends StatefulWidget {
  const ProjectSec({super.key});

  @override
  _ProjectSecState createState() => _ProjectSecState();
}

class _ProjectSecState extends State<ProjectSec> {
  @override
  void initState() {
    super.initState();
    
    // Memanggil Cubit untuk mengambil daftar project
    context.read<ProjectCubit>().fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects Section'),
      ),
      body: const ProjectBody(), // Memanggil ProjectBody di sini
    );
  }
}
