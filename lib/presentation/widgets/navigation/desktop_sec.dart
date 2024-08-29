import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/navigation_cubit.dart';

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Drawer header dengan tinggi tetap
              Container(
                height: 250, // Tinggi header
                color: Colors.blue, // Warna latar belakang header
                child: const Center(
                  child: Text(
                    'Navigation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Item navigasi
              _buildNavItem(context, 'Home', 0, state == NavigationState.homesec),
              _buildNavItem(context, 'About Us', 1, state == NavigationState.aboutsec),
              _buildNavItem(context, 'Projects', 2, state == NavigationState.projectsec),
              _buildNavItem(context, 'Contact', 3, state == NavigationState.contactsec),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context, String title, int index, bool isSelected) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.blue : Colors.black),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blue[100], // Warna latar belakang ketika dipilih
      onTap: () {
        // Menggunakan metode navigasi dari NavigationCubit berdasarkan index
        switch (index) {
          case 0:
            BlocProvider.of<NavigationCubit>(context).navigateToshowHomeSec();
            break;
          case 1:
            BlocProvider.of<NavigationCubit>(context).navigateToshowAboutSec();
            break;
          case 2:
            BlocProvider.of<NavigationCubit>(context).navigateToshowProjectSec();
            break;
          case 3:
            BlocProvider.of<NavigationCubit>(context).navigateToshowContactSec();
            break;
        }
      },
    );
  }
}
