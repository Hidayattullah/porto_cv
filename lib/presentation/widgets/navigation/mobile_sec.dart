import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../../pages/content/experience_sec.dart';
import '../../pages/content/home_sec.dart';
import '../../pages/content/project_sec.dart';
import '../../pages/content/contact_sec.dart';

class MobileSec extends StatelessWidget {
  const MobileSec({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Sticky Header untuk Home
        SliverStickyHeader(
          header: Container(
            height: 60.0,
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          sliver: const SliverToBoxAdapter(child: HomeSec()),
        ),

        // Sticky Header untuk About
        SliverStickyHeader(
          header: Container(
            height: 60.0,
            color: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Experience',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          sliver: const SliverToBoxAdapter(child: ExperienceSec()),
        ),

        // Sticky Header untuk Projects
        SliverStickyHeader(
          header: Container(
            height: 60.0,
            color: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Projects',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          sliver: const SliverToBoxAdapter(child: ProjectSec()),
        ),

        // Sticky Header untuk Contact
        SliverStickyHeader(
          header: Container(
            height: 60.0,
            color: Colors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Contact',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          sliver: const SliverToBoxAdapter(child: ContactSec()),
        ),
      ],
    );
  }
}
