// lib/widgets/navigation/navigation_footer.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching URLs

class NavigationFooter extends StatelessWidget {
  const NavigationFooter({super.key});

  // Helper method to launch URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Footer height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20), // Space between text and icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _launchURL('https://github.com/Hidayattullah'),
                child: const Icon(Icons.code, color: Colors.black), // GitHub icon
              ),
              const SizedBox(width: 15), // Space between icons
              GestureDetector(
                onTap: () => _launchURL('https://www.linkedin.com/in/tubagus-rifan-74b828240/'),
                child: const Icon(Icons.business, color: Colors.black), // LinkedIn icon
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () => _launchURL('https://www.instagram.com/yourprofile'),
                child: const Icon(Icons.camera_alt, color: Colors.black), // Instagram icon
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () => _launchURL('https://www.facebook.com/yourprofile'),
                child: const Icon(Icons.facebook, color: Colors.black), // Facebook icon
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () => _launchURL('https://vk.com/yourprofile'),
                child: const Icon(Icons.people, color: Colors.black), // VK icon
              ),
            ],
          ),
        ],
      ),
    );
  }
}
