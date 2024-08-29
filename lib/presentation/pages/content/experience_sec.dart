import 'package:flutter/material.dart';
import '../../widgets/cards/ovalcard.dart'; // Mengimpor OvalCard dari ovalcard.dart

class ExperienceSec extends StatelessWidget {
  const ExperienceSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height,
      child: const SingleChildScrollView(
        // Menambahkan scroll view untuk memungkinkan scroll ketika konten terlalu panjang
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OvalCard(
                title: 'Experience 1',
                description: 'Detail tentang pengalaman 1',
              ),
              SizedBox(height: 20), // Jarak antara card
              OvalCard(
                title: 'Experience 2',
                description: 'Detail tentang pengalaman 2',
              ),
              SizedBox(height: 20), // Jarak antara card
              OvalCard(
                title: 'Experience 3',
                description: 'Detail tentang pengalaman 3',
              ),
              SizedBox(height: 20), // Jarak antara card
              OvalCard(
                title: 'Experience 4',
                description: 'Detail tentang pengalaman 4',
              ),
              SizedBox(height: 20), // Jarak antara card
              OvalCard(
                title: 'Experience 5',
                description: 'Detail tentang pengalaman 5',
              ),
              SizedBox(height: 20), // Jarak antara card
              OvalCard(
                title: 'Experience 6',
                description: 'Detail tentang pengalaman 6',
              ),
              SizedBox(height: 20), // Jarak antara card
              OvalCard(
                title: 'Experience 7',
                description: 'Detail tentang pengalaman 7',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
