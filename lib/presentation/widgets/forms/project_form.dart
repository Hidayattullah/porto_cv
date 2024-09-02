// File: presentation/widgets/project_form.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Package untuk membuat ID unik
import '../../../domain/entities/project_entity.dart';

class ProjectForm extends StatefulWidget {
  final Function(ProjectEntity) onSubmit;

  const ProjectForm({required this.onSubmit, super.key});

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Project'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              onSaved: (value) => _title = value ?? '',
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a title' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              onSaved: (value) => _description = value ?? '',
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter a description'
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              final newProject = ProjectEntity(
                id: const Uuid().v4(), // Menggunakan UUID untuk membuat ID unik
                title: _title,
                description: _description,
                startDate: DateTime.now(),
                endDate: DateTime.now().add(const Duration(days: 30)), // Contoh endDate
                isCompleted: false, // Default belum selesai
              );
              widget.onSubmit(newProject);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
