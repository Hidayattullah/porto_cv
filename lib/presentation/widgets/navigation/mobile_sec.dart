import 'package:flutter/material.dart';
import '../../pages/content/about_sec.dart';
import '../../pages/content/home_sec.dart';
import '../../pages/content/project_sec.dart';
import '../../pages/content/contact_sec.dart';

class MobileSec extends StatefulWidget {
  const MobileSec({super.key});

  @override
  _MobileSecState createState() => _MobileSecState();
}

class _MobileSecState extends State<MobileSec> {
  late ScrollController _scrollController;
  int _currentSectionIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    int newSectionIndex = _getSectionIndexFromOffset(offset);

    if (newSectionIndex != _currentSectionIndex) {
      setState(() {
        _currentSectionIndex = newSectionIndex;
      });
    }
  }

  int _getSectionIndexFromOffset(double offset) {
    // Perkirakan panjang tiap konten untuk menentukan kapan header aktif
    if (offset < 670) return 0; // Home
    if (offset < 1340) return 1; // About
    if (offset < 2000) return 2; // Projects
    return 3; // Contact
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Header untuk Home
        SliverPersistentHeader(
          pinned: _currentSectionIndex == 0,
          delegate: _SliverHeaderDelegate(
            minHeight: 60.0,
            maxHeight: 60.0,
            color: Colors.blue,
            text: 'Home',
          ),
        ),
        const SliverToBoxAdapter(child: HomeSec()),

        // Header untuk About
        SliverPersistentHeader(
          pinned: _currentSectionIndex == 1,
          delegate: _SliverHeaderDelegate(
            minHeight: 60.0,
            maxHeight: 60.0,
            color: Colors.green,
            text: 'About',
          ),
        ),
        const SliverToBoxAdapter(child: AboutSec()),

        // Header untuk Projects
        SliverPersistentHeader(
          pinned: _currentSectionIndex == 2,
          delegate: _SliverHeaderDelegate(
            minHeight: 60.0,
            maxHeight: 60.0,
            color: Colors.red,
            text: 'Projects',
          ),
        ),
        const SliverToBoxAdapter(child: ProjectSec()),

        // Header untuk Contact
        SliverPersistentHeader(
          pinned: _currentSectionIndex == 3,
          delegate: _SliverHeaderDelegate(
            minHeight: 60.0,
            maxHeight: 60.0,
            color: Colors.purple,
            text: 'Contact',
          ),
        ),
        const SliverToBoxAdapter(child: ContactSec()),
      ],
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Color color;
  final String text;

  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.color,
    required this.text,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        color != oldDelegate.color ||
        text != oldDelegate.text;
  }
}
