import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../pages/contact/contact_sec.dart';
import '../pages/content/home_sec.dart';
import '../pages/experience/experience_sec.dart';
import '../pages/project/project_sec.dart';


class StickySection extends StatelessWidget {
  const StickySection({super.key});

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

        // Sticky Header untuk Experience
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
          // Membatasi tinggi dari ExperienceSec agar tidak infinite
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: const ExperienceSec(),
            ),
          ),
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
          // Membatasi tinggi dari ProjectSec agar tidak infinite
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: const ProjectSec(),
            ),
          ),
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
          // Membatasi tinggi dari ContactSec agar tidak infinite
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: const ContactSec(),
            ),
          ),
        ),
      ],
    );
  }
}
