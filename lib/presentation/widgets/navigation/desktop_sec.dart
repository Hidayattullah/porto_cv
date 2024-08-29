import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/navigation_cubit.dart';

class DesktopSec extends StatelessWidget {
  const DesktopSec({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>( // Menggunakan NavigationCubit dan int sebagai state
      builder: (context, state) {
        return Container(
          width: 200, // Ukuran untuk navigasi di desktop
          color: Colors.grey[200], // Warna latar belakang untuk navigasi
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildNavItem(context, 'Home', 0, state == 0),
              _buildNavItem(context, 'About Us', 1, state == 1),
              _buildNavItem(context, 'Projects', 2, state == 2),
              _buildNavItem(context, 'Contact', 3, state == 3),
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
      onTap: () {
        // Menggunakan metode navigateToSection dari NavigationCubit
        BlocProvider.of<NavigationCubit>(context).navigateToSection(index);
      },
    );
  }
}
