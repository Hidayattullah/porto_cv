// lib/widgets/sections/home_sec.dart
import 'package:flutter/material.dart';

class HomeSec extends StatelessWidget {
  const HomeSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0), // Add padding for all sides
      height: MediaQuery.of(context).size.height,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Back in 2014, I tried my hand at creating a web-based application using simple PHP, HTML, CSS, and MySQL to build an inventory tracking system for campus items. I also worked on a simple web platform project to help computer technicians be more easily found by customers. Fast forward, and I had the privilege of building a web app for a church and an airline company using Flutter and NodeJS (NestJS)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
              height: 1.5, // Line height for better readability
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20), // Space between paragraphs
          Text(
            'My main focus these days is on building accessible user interfaces for users. I am also focused on creating robust backend systems.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
              height: 1.5,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20), // Space between paragraphs
          Text(
            'When I’m not at the computer, I practice music, hang out with my partner, read books, and watch movies.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
              height: 1.1,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
