import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/navigation_cubit.dart';

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              _buildDrawerItem(
                context,
                icon: Icons.home,
                title: 'Home',
                isSelected: state == 0,
                onTap: () => BlocProvider.of<NavigationCubit>(context).showHomePage(),
              ),
              _buildDrawerItem(
                context,
                icon: Icons.person,
                title: 'About',
                isSelected: state == 1,
                onTap: () => BlocProvider.of<NavigationCubit>(context).showAboutPage(),
              ),
              _buildDrawerItem(
                context,
                icon: Icons.work,
                title: 'Projects',
                isSelected: state == 2,
                onTap: () => BlocProvider.of<NavigationCubit>(context).showProjectPage(),
              ),
              _buildDrawerItem(
                context,
                icon: Icons.contact_mail,
                title: 'Contact',
                isSelected: state == 3,
                onTap: () => BlocProvider.of<NavigationCubit>(context).showContactPage(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawerItem(BuildContext context, {required IconData icon, required String title, required bool isSelected, required Function onTap}) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.blue : Theme.of(context).textTheme.bodyLarge?.color),
      ),
      tileColor: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
      onTap: () {
        onTap();
        Navigator.pop(context); // Close the drawer
      },
    );
  }
}
