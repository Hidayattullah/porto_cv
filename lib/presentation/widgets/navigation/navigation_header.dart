// lib/widgets/navigation/navigation_header.dart
import 'package:flutter/material.dart';

class NavigationHeader extends StatelessWidget {
  const NavigationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Tinggi header
      color: Colors.blue, // Warna latar belakang header
      child: const Center(
        child: Text(
          'Navigation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
