import 'package:flutter/material.dart';

class AboutSec extends StatelessWidget {
  const AboutSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: Text('About Section', 
        style: TextStyle(
          color: Colors.white, fontSize: 24
          )
        )
      ),
    );
  }
}
