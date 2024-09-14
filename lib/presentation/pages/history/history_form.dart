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
    final linkController = TextEditingController(); // Tambahkan TextEditingController untuk link
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
            // Apply Date otomatis tidak perlu diinput manual
            TextField(
              controller: sourceController,
              decoration: const InputDecoration(labelText: 'Source'),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            TextField(
              controller: linkController, // TextField untuk link
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
            final newHistory = HistoryEntity(
              id: uuid.v4(), // Generate a new unique ID using UUID
              companyName: companyNameController.text,
              jobTitle: jobTitleController.text,
              applyDate: DateTime.now(), // Set otomatis apply date ke waktu sekarang
              source: sourceController.text,
              status: statusController.text,
              link: linkController.text, // Set nilai link dari TextField
            );

            onAddHistory(newHistory);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
