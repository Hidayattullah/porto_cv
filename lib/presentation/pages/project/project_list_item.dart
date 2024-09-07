import 'package:flutter/material.dart';
import '../../../domain/entities/project_entity.dart';

class ProjectListItem extends StatelessWidget {
  final ProjectEntity project;

  const ProjectListItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: Text(
          project.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        subtitle: Text(
          project.description.isNotEmpty ? project.description : 'No description available',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        // No trailing CRUD actions needed here, just basic information display
      ),
    );
  }
}
