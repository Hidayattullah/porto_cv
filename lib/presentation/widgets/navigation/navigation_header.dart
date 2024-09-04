// lib/widgets/navigation/navigation_header.dart
import 'package:flutter/material.dart';

class NavigationHeader extends StatelessWidget {
  const NavigationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0), // Pemberian padding pada header
      height: 250, // Tinggi header
      color: Colors.blueGrey[900], // Warna latar belakang header
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tubagus Rifan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8), // Jarak antar elemen
          Text(
            'Junior Fullstack Developer',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 16), // Jarak antar elemen
          Text(
            'Transforming ideas into efficient and scalable digital solutions.',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
