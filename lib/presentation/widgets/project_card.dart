import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(project),
        subtitle: Text('Description of $project'),
      ),
    );
  }
}
