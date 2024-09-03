import 'package:flutter/material.dart';

class OvalCard extends StatelessWidget {
  final String title;
  final String description;
  final bool showButtons; // Menampilkan tombol update dan delete hanya jika user login
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const OvalCard({
    super.key,
    required this.title,
    required this.description,
    required this.showButtons,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(description),
            if (showButtons) // Tampilkan tombol hanya jika showButtons == true
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onUpdate,
                    child: const Text('Update'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: onDelete,
                    child: const Text('Delete'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
