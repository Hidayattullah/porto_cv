import 'package:flutter/material.dart';

class ContactSec extends StatelessWidget {
  const ContactSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 166, 0),
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: Text('Contact Section', 
        style: TextStyle(
          color: Colors.white, fontSize: 24
          )
        )
      ),
    );
  }
}
