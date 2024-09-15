import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../pages/contact/contact_sec.dart';
import '../pages/content/home_sec.dart';
import '../pages/experience/experience_sec.dart';
import '../pages/project/project_sec.dart';
import '../pages/history/history_sec.dart'; // Import history section

class StickySection extends StatelessWidget {
  const StickySection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Sticky Header for Home
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

        // Sticky Header for Experience
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
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: const ExperienceSec(),
            ),
          ),
        ),

        // Sticky Header for Projects
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
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: const ProjectSec(),
            ),
          ),
        ),

        // Sticky Header for Contact
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
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: const ContactSec(),
            ),
          ),
        ),

        // Conditionally Render History Section Based on Authentication State
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return SliverStickyHeader(
                header: Container(
                  height: 60.0,
                  color: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'History',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: const HistorySec(), // Display history section if authenticated
                  ),
                ),
              );
            }
            return const SliverToBoxAdapter(); // Return an empty widget if not authenticated
          },
        ),
      ],
    );
  }
}
