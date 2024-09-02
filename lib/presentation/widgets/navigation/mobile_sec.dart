import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';
import '../../pages/content/experience_sec.dart';
import '../../pages/content/home_sec.dart';
import '../../pages/content/project_sec.dart';
import '../../pages/content/contact_sec.dart';

class MobileSec extends StatelessWidget {
  const MobileSec({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Notifikasi ketika berhasil login
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Login berhasil!'),
                ],
              ),
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is AuthUnauthenticated) {
          // Notifikasi ketika berhasil logout
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.info, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Logout berhasil!'),
                ],
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // Sticky Header untuk Home
            SliverStickyHeader(
              header: Container(
                height: 60.0,
                color: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              sliver: const SliverToBoxAdapter(child: HomeSec()),
            ),

            // Sticky Header untuk Experience
            SliverStickyHeader(
              header: Container(
                height: 60.0,
                color: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Experience',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              sliver: const SliverToBoxAdapter(child: ExperienceSec()),
            ),

            // Sticky Header untuk Projects
            SliverStickyHeader(
              header: Container(
                height: 60.0,
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Projects',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              sliver: const SliverToBoxAdapter(child: ProjectSec()),
            ),

            // Sticky Header untuk Contact
            SliverStickyHeader(
              header: Container(
                height: 60.0,
                color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Contact',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              sliver: const SliverToBoxAdapter(child: ContactSec()),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is AuthAuthenticated) {
              // Jika pengguna sudah login, tampilkan tombol logout
              return FloatingActionButton(
                onPressed: () {
                  // Panggil fungsi logout dari AuthCubit
                  context.read<AuthCubit>().signOut();
                },
                child: const Icon(Icons.logout), // Ubah ikon menjadi logout
              );
            } else {
              // Jika belum login, tampilkan tombol login
              return FloatingActionButton(
                onPressed: () {
                  // Navigasi ke halaman login
                  Navigator.pushNamed(context, '/login');
                },
                child: const Icon(Icons.login), // Ikon login
              );
            }
          },
        ),
      ),
    );
  }
}
