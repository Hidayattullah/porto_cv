import 'package:flutter/material.dart';
import '../project/project_list_page.dart';

class ProjectSec extends StatelessWidget {
  const ProjectSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 0, 149),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Project Section',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20), // Memberi jarak antara teks dan tombol
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectListPage(),
                ),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black, // Warna latar belakang tombol
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ),
            child: const Text(
              'View All Projects',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
