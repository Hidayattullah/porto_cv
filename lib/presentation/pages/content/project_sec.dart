import 'package:flutter/material.dart';

class ProjectSec extends StatelessWidget {
  const ProjectSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 0, 149),
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: Text('Project Section', 
        style: TextStyle(
          color: Colors.white, fontSize: 24
          )
        )
      ),
    );
  }
}
