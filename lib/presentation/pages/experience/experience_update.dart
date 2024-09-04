import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import '../../../domain/entities/experience_entity.dart';
import '../../cubits/experience/experience_cubit.dart';

class ExperienceListUpdate extends StatelessWidget {
  final ExperienceEntity experience;

  const ExperienceListUpdate({required this.experience, super.key});

  @override 
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: experience.title);
    final descriptionController = TextEditingController(text: experience.description);
    final startDateController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(experience.startDate));
    final endDateController = TextEditingController(text: experience.endDate != null ? DateFormat('dd-MM-yyyy').format(experience.endDate!) : '');

    return AlertDialog(
      title: const Text('Update Experience'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          TextField(
            controller: startDateController,
            decoration: const InputDecoration(
              labelText: 'Start Date (dd-MM-yyyy)',
            ),
            keyboardType: TextInputType.datetime,
          ),
          TextField(
            controller: endDateController,
            decoration: const InputDecoration(
              labelText: 'End Date (dd-MM-yyyy)',
            ),
            keyboardType: TextInputType.datetime,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Parsing dates from input
            DateTime? startDate;
            DateTime? endDate;
            try {
              startDate = DateFormat('dd-MM-yyyy').parse(startDateController.text);
              if (endDateController.text.isNotEmpty) {
                endDate = DateFormat('dd-MM-yyyy').parse(endDateController.text);
              }
            } catch (e) {
              // Handle date parsing error
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invalid date format. Please use dd-MM-yyyy')),
              );
              return;
            }

            // Update experience logic
            final updatedExperience = experience.copyWith(
              title: titleController.text,
              description: descriptionController.text,
              startDate: startDate,
              endDate: endDate,
            );

            context.read<ExperienceCubit>().updateExistingExperience(updatedExperience);
            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
