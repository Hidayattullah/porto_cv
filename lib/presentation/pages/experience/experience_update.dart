import 'package:flutter/material.dart';
import '../../../domain/entities/experience_entity.dart';
import 'package:intl/intl.dart';

class UpdateExperienceDialog extends StatelessWidget {
  final ExperienceEntity experience;
  final Function(ExperienceEntity) onUpdateExperience;

  const UpdateExperienceDialog({
    super.key,
    required this.experience,
    required this.onUpdateExperience,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: experience.title);
    final companyController = TextEditingController(text: experience.company);
    final descriptionController = TextEditingController(text: experience.description);
    final startDateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(experience.startDate));
    final endDateController = TextEditingController(
        text: experience.endDate != null ? DateFormat('yyyy-MM-dd').format(experience.endDate!) : '');

    return AlertDialog(
      title: const Text('Update Experience'),
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
              decoration: const InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
            ),
            TextField(
              controller: endDateController,
              decoration: const InputDecoration(labelText: 'End Date (YYYY-MM-DD, optional)'),
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
          child: const Text('Update'),
          onPressed: () {
            final title = titleController.text;
            final company = companyController.text;
            final description = descriptionController.text;
            final startDate = DateTime.tryParse(startDateController.text);
            final endDate = endDateController.text.isNotEmpty
                ? DateTime.tryParse(endDateController.text)
                : null;

            if (title.isNotEmpty && company.isNotEmpty && startDate != null && description.isNotEmpty) {
              final updatedExperience = ExperienceEntity(
                id: experience.id, // ID pengalaman yang akan di-update
                title: title,
                company: company,
                startDate: startDate,
                endDate: endDate,
                description: description,
                tags: experience.tags, // Tetap menggunakan tags yang sudah ada
              );

              onUpdateExperience(updatedExperience);
              Navigator.of(context).pop(); // Tutup dialog setelah update
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
