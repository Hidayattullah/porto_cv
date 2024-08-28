import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/navigation_cubit.dart';

class DesktopNavBar extends StatelessWidget {
  const DesktopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavBarItem(
              context,
              title: 'Home',
              isSelected: state == 0,
              onTap: () => BlocProvider.of<NavigationCubit>(context).showHomePage(),
            ),
            _buildNavBarItem(
              context,
              title: 'About',
              isSelected: state == 1,
              onTap: () => BlocProvider.of<NavigationCubit>(context).showAboutPage(),
            ),
            _buildNavBarItem(
              context,
              title: 'Projects',
              isSelected: state == 2,
              onTap: () => BlocProvider.of<NavigationCubit>(context).showProjectPage(),
            ),
            _buildNavBarItem(
              context,
              title: 'Contact',
              isSelected: state == 3,
              onTap: () => BlocProvider.of<NavigationCubit>(context).showContactPage(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNavBarItem(BuildContext context, {required String title, required bool isSelected, required Function onTap}) {
    return TextButton(
      onPressed: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}
