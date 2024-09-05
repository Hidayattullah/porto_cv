import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/project_entity.dart';
import '../../cubits/project/project_cubit.dart';

class ProjectListUpdate extends StatelessWidget {
  final ProjectEntity project;

  const ProjectListUpdate({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: project.title);
    final descriptionController = TextEditingController(text: project.description);
    final yearMadeController = TextEditingController(text: project.yearMade); // Menggunakan String
    final builtWithController = TextEditingController(text: project.builtWith);
    final madeAtController = TextEditingController(text: project.madeAt);
    final linkController = TextEditingController(text: project.link);

    return AlertDialog(
      title: const Text('Update Project'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Input field untuk title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Project Title'),
            ),
            // Input field untuk description
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Project Description'),
              maxLines: 3,
            ),
            // Input field untuk year made (String)
            TextField(
              controller: yearMadeController,
              decoration: const InputDecoration(labelText: 'Year Made'),
            ),
            // Input field untuk built with
            TextField(
              controller: builtWithController,
              decoration: const InputDecoration(labelText: 'Built With'),
            ),
            // Input field untuk made at
            TextField(
              controller: madeAtController,
              decoration: const InputDecoration(labelText: 'Made At'),
            ),
            // Input field untuk link
            TextField(
              controller: linkController,
              decoration: const InputDecoration(labelText: 'Link'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Membuat instance baru dari ProjectEntity dengan data yang diperbarui
            final updatedProject = ProjectEntity(
              id: project.id,
              title: titleController.text,
              description: descriptionController.text,
              yearMade: yearMadeController.text, // Menggunakan String
              builtWith: builtWithController.text,
              madeAt: madeAtController.text,
              link: linkController.text,
            );

            // Memanggil cubit untuk memperbarui project
            context.read<ProjectCubit>().updateExistingProject(updatedProject);

            // Menutup dialog setelah update
            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
