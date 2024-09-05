import 'package:flutter/material.dart';
import '../../../domain/entities/project_entity.dart';

class ProjectForm extends StatelessWidget {
  final Function(ProjectEntity) onAddProject;

  const ProjectForm({super.key, required this.onAddProject});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final yearController = TextEditingController();
    final builtWithController = TextEditingController();
    final madeAtController = TextEditingController();
    final linkController = TextEditingController();

    return AlertDialog(
      title: const Text('Add New Project'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Year'),
            ),
            TextField(
              controller: builtWithController,
              decoration: const InputDecoration(labelText: 'Built With'),
            ),
            TextField(
              controller: madeAtController,
              decoration: const InputDecoration(labelText: 'Made At'),
            ),
            TextField(
              controller: linkController,
              decoration: const InputDecoration(labelText: 'Project Link'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Add'),
          onPressed: () {
            final title = titleController.text;
            final description = descriptionController.text;
            final year = yearController.text;
            final builtWith = builtWithController.text;
            final madeAt = madeAtController.text;
            final link = linkController.text;

            if (title.isNotEmpty && description.isNotEmpty && year.isNotEmpty && builtWith.isNotEmpty && madeAt.isNotEmpty) {
              final newProject = ProjectEntity(
                id: '', // ID will be generated automatically
                title: title,
                description: description,
                yearMade: year,
                builtWith: builtWith,
                madeAt: madeAt,
                link: link,
              );

              onAddProject(newProject);
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All fields are required!')),
              );
            }
          },
        ),
      ],
    );
  }
}
