// lib/widgets/navigation/desktop_sec.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/navigation_cubit.dart';
import 'navigation_header.dart'; // Import NavigationHeader
import 'navigation_footer.dart'; // Import NavigationFooter

class DesktopSec extends StatelessWidget {
  const DesktopSec({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Container(
          width: 500, // Ukuran untuk navigasi di desktop
          color: Colors.grey[200], // Warna latar belakang untuk navigasi
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Mengatur main axis untuk menempatkan footer di bawah
            children: [
              const NavigationHeader(), // Menggunakan widget NavigationHeader

              Expanded( // Membuat list tile menggunakan sisa ruang
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildNavItem(context, 'Home', NavigationState.homesec, state == NavigationState.homesec),
                    _buildNavItem(context, 'Experience', NavigationState.experiencesec, state == NavigationState.experiencesec),
                    _buildNavItem(context, 'Projects', NavigationState.projectsec, state == NavigationState.projectsec),
                    _buildNavItem(context, 'Contact', NavigationState.contactsec, state == NavigationState.contactsec),
                  ],
                ),
              ),

              const NavigationFooter(), // Menggunakan widget NavigationFooter
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context, String title, NavigationState sectionState, bool isSelected) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.blue : Colors.black),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blue[100], // Warna latar belakang ketika dipilih
      onTap: () {
        // Menggunakan metode navigasi dari NavigationCubit berdasarkan sectionState
        final navigationCubit = BlocProvider.of<NavigationCubit>(context);
        switch (sectionState) {
          case NavigationState.homesec:
            navigationCubit.navigateToshowHomeSec();
            break;
          case NavigationState.experiencesec:
            navigationCubit.navigateToshowExperienceSec();
            break;
          case NavigationState.projectsec:
            navigationCubit.navigateToshowProjectSec();
            break;
          case NavigationState.contactsec:
            navigationCubit.navigateToshowContactSec();
            break;
        }
      },
    );
  }
}
