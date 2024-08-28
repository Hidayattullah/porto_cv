import 'package:flutter/material.dart';
import '../components/desktop_nav_bar.dart';
import '../components/mobile_nav_bar.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const MobileNavBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('These are my Projects.'),
          ],
        ),
      ),
      bottomNavigationBar: const DesktopNavBar(),
    );
  }
}
