import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/experience_entity.dart';
import '../../cubits/experience/experience_cubit.dart';

class ExperienceListUpdate extends StatelessWidget {
  final ExperienceEntity experience;

  const ExperienceListUpdate({required this.experience, super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: experience.title);
    final companyController = TextEditingController(text: experience.company);
    final descriptionController = TextEditingController(text: experience.description);
    final startDateController = TextEditingController(text: experience.startDate);
    final endDateController = TextEditingController(text: experience.endDate);

    return AlertDialog(
      title: const Text('Update Experience'),
      content: Column(
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
      actions: [
        TextButton(
          onPressed: () {
            final updatedExperience = ExperienceEntity(
              id: experience.id,
              title: titleController.text,
              company: companyController.text,
              startDate: startDateController.text,
              endDate: endDateController.text,
              description: descriptionController.text,
              tags: experience.tags,
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
