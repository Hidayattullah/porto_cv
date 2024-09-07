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
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  ),
                ],
        ),
        child: ListTile(
          title: InkWell(
            onTap: () {
              _launchURL(widget.project.link); // Opens link from the database
            },
            child: Text(
              widget.project.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isHovering ? Colors.blue.shade700 : Colors.blueAccent,
                decoration: _isHovering
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
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
