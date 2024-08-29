import 'package:flutter/material.dart';

class OvalCard extends StatelessWidget {
  final String title;
  final String description;

  const OvalCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.5; // Lebar card sebagai persentase dari lebar layar

    return SizedBox(
      width: cardWidth,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Menggunakan radius oval
        ),
        elevation: 5,
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50, // Lebar header samping
            color: Colors.blue, // Warna header
            child: const Center(
              child: Text(
                'Header',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          isThreeLine: true, // Mengatur agar subtitle dapat menggunakan beberapa baris
        ),
      ),
    );
  }
}
