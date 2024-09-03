import 'package:flutter/material.dart';

class OvalListItem extends StatelessWidget {
  final String title;
  final String description;
  final bool showButtons; // Menampilkan tombol update dan delete hanya jika user login
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final VoidCallback onTap; // Untuk menghandle klik

  const OvalListItem({
    super.key,
    required this.title,
    required this.description,
    required this.showButtons,
    required this.onUpdate,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap, // Aksi ketika item di-klik
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 8),
              Text(description),
              if (showButtons)
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
      ),
    );
  }
}

