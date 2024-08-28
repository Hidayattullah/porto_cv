import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blueGrey,
      child: const Center(
        child: Text(
          '© 2024 My Portfolio',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
