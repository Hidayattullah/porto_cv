// File: presentation/widgets/project_form.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Package untuk membuat ID unik
import '../../../domain/entities/project_entity.dart';

class ProjectForm extends StatefulWidget {
  final ProjectEntity? project; // Tambahkan parameter untuk proyek yang sudah ada
  final Function(ProjectEntity) onSubmit;

  const ProjectForm({this.project, required this.onSubmit, super.key});

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    // Inisialisasi nilai form berdasarkan proyek yang sudah ada, jika ada
    _title = widget.project?.title ?? '';
    _description = widget.project?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.project == null ? 'Add New Project' : 'Edit Project'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              onSaved: (value) => _title = value ?? '',
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a title' : null,
            ),
            TextFormField(
              initialValue: _description,
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

              // Cek apakah kita sedang membuat proyek baru atau mengedit yang sudah ada
              final newProject = ProjectEntity(
                id: widget.project?.id ?? const Uuid().v4(), // Jika proyek ada, gunakan ID yang sama
                title: _title,
                description: _description,
                startDate: widget.project?.startDate ?? DateTime.now(), // Gunakan startDate proyek yang ada atau default
                endDate: widget.project?.endDate ?? DateTime.now().add(const Duration(days: 30)), // Gunakan endDate proyek yang ada atau default
                isCompleted: widget.project?.isCompleted ?? false, // Gunakan status proyek yang ada atau default
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
