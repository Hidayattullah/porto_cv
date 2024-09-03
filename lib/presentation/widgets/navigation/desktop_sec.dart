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
          // Menampilkan notifikasi ketika berhasil login
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
          // Menampilkan notifikasi ketika berhasil logout
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
                width: 500, // Ukuran untuk navigasi di desktop
                color: Colors.grey[200], // Warna latar belakang untuk navigasi
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Mengatur main axis untuk menempatkan footer di bawah
                  children: [
                    const NavigationHeader(), // Menggunakan widget NavigationHeader
                    
                    // Menampilkan email jika pengguna telah login
                    if (authState is AuthAuthenticated) 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Logged in as: ${authState.email}', // Menampilkan email pengguna
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    
                    // Membungkus list tile dengan SingleChildScrollView
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildNavItem(context, 'Home', NavigationState.homesec, navState == NavigationState.homesec),
                            _buildNavItem(context, 'Experience', NavigationState.experiencesec, navState == NavigationState.experiencesec),
                            _buildNavItem(context, 'Projects', NavigationState.projectsec, navState == NavigationState.projectsec),
                            _buildNavItem(context, 'Contact', NavigationState.contactsec, navState == NavigationState.contactsec),
                            
                            // Menampilkan tombol Login atau Logout
                            ListTile(
                              title: Text(
                                authState is AuthAuthenticated ? 'Logout' : 'Login',
                                style: const TextStyle(color: Colors.black),
                              ),
                              onTap: () {
                                if (authState is AuthAuthenticated) {
                                  // Jika pengguna sudah login, panggil fungsi logout
                                  context.read<AuthCubit>().signOut();
                                } else {
                                  // Jika belum login, navigasi ke halaman login
                                  Navigator.pushNamed(context, '/login');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const NavigationFooter(), // Menggunakan widget NavigationFooter
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
