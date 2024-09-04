import 'package:flutter/material.dart';
import '../../../domain/entities/experience_entity.dart';

class ExperienceForm extends StatelessWidget {
  final Function(ExperienceEntity) onAddExperience;

  const ExperienceForm({super.key, required this.onAddExperience});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final companyController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();
    final descriptionController = TextEditingController();

    return AlertDialog(
      title: const Text('Add New Experience'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: companyController,
              decoration: const InputDecoration(labelText: 'Company'),
            ),
            TextField(
              controller: startDateController,
              decoration: const InputDecoration(labelText: 'Start Date'),
            ),
            TextField(
              controller: endDateController,
              decoration: const InputDecoration(labelText: 'End Date'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
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
            final company = companyController.text;
            final startDate = startDateController.text;
            final endDate = endDateController.text;
            final description = descriptionController.text;

            if (title.isNotEmpty && company.isNotEmpty && startDate.isNotEmpty && description.isNotEmpty) {
              final newExperience = ExperienceEntity(
                id: '', // ID akan digenerate saat menambah ke database
                title: title,
                company: company,
                startDate: startDate,
                endDate: endDate,
                description: description,
                tags: [], // Kosongkan atau isi dengan tags yang sesuai
              );

              onAddExperience(newExperience);
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
