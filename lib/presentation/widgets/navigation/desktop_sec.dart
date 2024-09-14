import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/auth/auth_state.dart';
import '../../cubits/navigation/navigation_cubit.dart';
import '../../cubits/auth/auth_cubit.dart';
import 'navigation_header.dart'; // Import NavigationHeader
import 'navigation_footer.dart'; // Import NavigationFooter

class DesktopSec extends StatelessWidget {
  const DesktopSec({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Show notification when login is successful
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Login berhasil!'),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is AuthUnauthenticated) {
          // Show notification when logout is successful
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.info, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Logout berhasil!'),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, navState) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              return Container(
                width: 500, // Size for navigation on desktop
                color: Colors.grey[200], // Background color for navigation
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Main axis for placing the footer at the bottom
                  children: [
                    const NavigationHeader(), // Using NavigationHeader widget
                    
                    // Display email if the user is logged in
                    if (authState is AuthAuthenticated)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Logged in as: ${authState.email}', // Display user email
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    
                    // Wrap list tile with SingleChildScrollView
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildNavItem(context, 'Home', NavigationState.homesec, navState == NavigationState.homesec),
                            _buildNavItem(context, 'Experience', NavigationState.experiencesec, navState == NavigationState.experiencesec),
                            _buildNavItem(context, 'Projects', NavigationState.projectsec, navState == NavigationState.projectsec),
                            _buildNavItem(context, 'Contact', NavigationState.contactsec, navState == NavigationState.contactsec),

                            // Show history section only if user is authenticated
                            if (authState is AuthAuthenticated)
                              _buildNavItem(context, 'History', NavigationState.historysec, navState == NavigationState.historysec),
                            
                            // Display Login or Logout button
                            ListTile(
                              title: Text(
                                authState is AuthAuthenticated ? 'Logout' : 'Login',
                                style: const TextStyle(color: Colors.black),
                              ),
                              onTap: () {
                                if (authState is AuthAuthenticated) {
                                  // If the user is logged in, call logout function
                                  context.read<AuthCubit>().signOut();
                                } else {
                                  // If not logged in, navigate to login page
                                  Navigator.pushNamed(context, '/login');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const NavigationFooter(), // Using NavigationFooter widget
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, NavigationState sectionState, bool isSelected) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.blue : Colors.black),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blue[100], // Background color when selected
      onTap: () {
        // Use NavigationCubit's navigation method based on sectionState
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
          case NavigationState.historysec:
            navigationCubit.navigateToshowHistorySec();
            break;
        }
      },
    );
  }
}
