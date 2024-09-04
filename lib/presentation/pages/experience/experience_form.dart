import 'package:flutter/material.dart';
import '../../../domain/entities/experience_entity.dart';

class ExperienceForm extends StatelessWidget {
  final Function(ExperienceEntity) onAddExperience;

  const ExperienceForm({super.key, required this.onAddExperience});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final companyController = TextEditingController();
    final descriptionController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();

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
              decoration: const InputDecoration(labelText: 'Start Date (DD-MM-YYYY)'),
            ),
            TextField(
              controller: endDateController,
              decoration: const InputDecoration(labelText: 'End Date (DD-MM-YYYY or PRESENT)'),
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
            final description = descriptionController.text;
            final startDate = DateTime.tryParse(startDateController.text);
            final endDate = endDateController.text.isNotEmpty
                ? DateTime.tryParse(endDateController.text)
                : null;

            if (title.isNotEmpty && company.isNotEmpty && startDate != null && description.isNotEmpty) {
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
              Navigator.of(context).pop(); // Tutup dialog setelah menambah
            } else {
              // Tampilkan pesan kesalahan atau feedback ke user jika input tidak valid
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all required fields.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
