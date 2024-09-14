import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/history_entitiy.dart';
import '../../cubits/history/history_cubit.dart';

class HistoryUpdate extends StatelessWidget {
  final HistoryEntity history;

  const HistoryUpdate({required this.history, super.key});

  @override
  Widget build(BuildContext context) {
    final companyNameController = TextEditingController(text: history.companyName);
    final jobTitleController = TextEditingController(text: history.jobTitle);
    final applyDateController = TextEditingController(text: history.applyDate.toIso8601String());
    final sourceController = TextEditingController(text: history.source);
    final statusController = TextEditingController(text: history.status);
    final linkController = TextEditingController(text: history.link);

    return AlertDialog(
      title: const Text('Update History'),
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
              controller: applyDateController,
              decoration: const InputDecoration(labelText: 'Apply Date (YYYY-MM-DD)'),
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            DateTime? applyDate;
            try {
              applyDate = DateTime.parse(applyDateController.text);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invalid date format. Please use YYYY-MM-DD.')),
              );
              return;
            }

            final updatedHistory = HistoryEntity(
              id: history.id,
              companyName: companyNameController.text,
              jobTitle: jobTitleController.text,
              applyDate: applyDate,
              source: sourceController.text,
              status: statusController.text,
              link: linkController.text,
            );

            context.read<HistoryCubit>().updateExistingHistory(updatedHistory);

            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
