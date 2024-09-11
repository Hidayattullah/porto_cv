import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/project_entity.dart';

class ProjectListItem extends StatefulWidget {
  final ProjectEntity project;

  const ProjectListItem({super.key, required this.project});

  @override
  _ProjectListItemState createState() => _ProjectListItemState();
}

class _ProjectListItemState extends State<ProjectListItem> {
  bool _isHovering = false;

  // Method to launch URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovering = true;
      }),
      onExit: (_) => setState(() {
        _isHovering = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: _isHovering ? Colors.white : Colors.grey[100], // Background color on hover
          borderRadius: BorderRadius.circular(5),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.6), // Shadow when hovering
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [], // No shadow when not hovering
        ),
        child: ListTile(
          onTap: () {
            _launchURL(widget.project.link); // Opens the project link
          },
          title: Text(
            widget.project.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          subtitle: Text(
            widget.project.description.isNotEmpty
                ? widget.project.description
                : 'No description available',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
