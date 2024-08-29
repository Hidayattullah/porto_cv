import 'package:flutter/material.dart';

class ContactSec extends StatelessWidget {
  const ContactSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
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
