import 'package:flutter/material.dart';
import '../widgets/navigation/desktop_sec.dart';
import '../widgets/navigation/mobile_sec.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktopMode = MediaQuery.of(context).size.width >= 1024;
    return Scaffold(
      body: isDesktopMode
          ? Row(
              children: [
                const DesktopSec(), // Side navigation untuk desktop
                Expanded(child: _buildScrollableContent()),
              ],
            )
          : const MobileSec(), // SliverPersistentHeader untuk mobile dan tablet
    );
  }

  Widget _buildScrollableContent() {
    return ListView(
      children: const [
        Text('Welcome to Home Page'),
        // Tambahkan konten lain sesuai kebutuhan
      ],
    );
  }
}
