import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/project_entity.dart';
import '../../cubits/project/project_cubit.dart';
import 'project_update.dart'; // Anda bisa membuat dialog update serupa dengan 'experience_update.dart'

class ProjectListItem extends StatelessWidget {
  final ProjectEntity project;

  const ProjectListItem({
    required this.project,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        onTap: () {
          // Aksi yang dijalankan ketika item di-tap (contoh: detail project)
          // Navigator.pushNamed(context, '/projectDetail', arguments: project);
        },
        title: Text(
          project.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        subtitle: Text(
          "Description: ${project.description.isNotEmpty ? project.description : 'No description available'}\n" // Tidak menggunakan ??
          "Year: ${project.yearMade}\n"
          "Built With: ${project.builtWith}\n"
          "Made At: ${project.madeAt}\n"
          "Link: ${project.link}",
        ),
        trailing: user != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Menampilkan dialog update project
                      showDialog(
                        context: context,
                        builder: (context) => ProjectListUpdate(
                          project: project,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Menghapus project menggunakan ProjectCubit
                      context.read<ProjectCubit>().removeProject(project.id);
                    },
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
