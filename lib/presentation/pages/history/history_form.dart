import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/history_entitiy.dart';

class HistoryForm extends StatelessWidget {
  final Function(HistoryEntity) onAddHistory;

  const HistoryForm({super.key, required this.onAddHistory});

  @override
  Widget build(BuildContext context) {
    final companyNameController = TextEditingController();
    final jobTitleController = TextEditingController();
    final sourceController = TextEditingController();
    final statusController = TextEditingController();
    final linkController = TextEditingController();
    const uuid = Uuid(); // Initialize UUID generator

    return AlertDialog(
      title: const Text('Add New History'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: companyNameController,
              decoration: const InputDecoration(labelText: 'Company Name'),
            ),
            TextField(
              controller: jobTitleController,
              decoration: const InputDecoration(labelText: 'Job Title'),
            ),
            TextField(
              controller: sourceController,
              decoration: const InputDecoration(labelText: 'Source'),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            TextField(
              controller: linkController,
              decoration: const InputDecoration(labelText: 'Link (Company Website)'),
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
            final companyName = companyNameController.text;
            final jobTitle = jobTitleController.text;
            final source = sourceController.text;
            final status = statusController.text;
            final link = linkController.text;

            if (companyName.isNotEmpty && jobTitle.isNotEmpty && source.isNotEmpty && status.isNotEmpty && link.isNotEmpty) {
              final newHistory = HistoryEntity(
                id: uuid.v4(), // Generate a new unique ID
                companyName: companyName,
                jobTitle: jobTitle,
                applyDate: DateTime.now(), // Set apply date to now
                source: source,
                status: status,
                link: link,
              );

              onAddHistory(newHistory);
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
