import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';
import '../sticky_section.dart';

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
              behavior: SnackBarBehavior.floating,
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
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        body: const StickySection(),  // Menggunakan StickySection yang dipisahkan
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
