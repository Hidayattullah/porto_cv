// lib/widgets/navigation/navigation_footer.dart
import 'package:flutter/material.dart';

class NavigationFooter extends StatelessWidget {
  const NavigationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180, // Tinggi footer, sama seperti yang diinginkan
      color: Colors.blue, // Warna latar belakang footer
      child: const Center(
        child: Text(
          'Footer',
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
