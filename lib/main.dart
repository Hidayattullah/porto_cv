// File: main.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porto_cv/firebase_options.dart';
import 'presentation/cubits/navigation/navigation_cubit.dart'; // Import NavigationCubit
import 'presentation/pages/auth/login.dart';
import 'presentation/pages/landing_page.dart';
import 'presentation/pages/project/project_list_page.dart';

// dependencies module
import 'dependencies/auth_dependency.dart';
import 'dependencies/project_dependency.dart';
import 'dependencies/contact_dependency.dart';
import 'dependencies/experience_dependency.dart'; // Import Experience Dependencies

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    print('Memulai inisialisasi Firebase...');
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Inisialisasi Firebase
  if (kDebugMode) {
    print('Firebase berhasil diinisialisasi.');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...provideAuthDependencies(), // Menggunakan Auth Dependencies
        ...provideProjectDependencies(), // Menggunakan Project Dependencies
        ...provideExperienceDependencies(), // Menggunakan Experience Dependencies
        ...provideContactDependencies(),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(), // Inisialisasi NavigationCubit
        ),
        // Tambahkan cubit atau provider lainnya di sini
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portfolio App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LandingPage(), // Halaman utama setelah login berhasil
        routes: {
          '/login': (context) => const LoginPage(), // Definisikan route untuk halaman login
          '/landing': (context) => const LandingPage(), // Rute ke landing_page
          '/projects': (context) => const ProjectListPage(), // Rute ke project_list_page
          // Tambahkan route lain jika diperlukan
        },
      ),
    );
  }
}
