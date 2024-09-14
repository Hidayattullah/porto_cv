// File: main.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porto_cv/firebase_options.dart';
import 'dependencies/project_dependency.dart';
import 'presentation/cubits/navigation/navigation_cubit.dart';
import 'presentation/pages/auth/login.dart';
import 'presentation/pages/landing_page.dart';

// dependencies module
import 'dependencies/auth_dependency.dart';
import 'dependencies/contact_dependency.dart';
import 'dependencies/experience_dependency.dart';
import 'presentation/pages/project/project_tabel.dart'; // Import Experience Dependencies
import 'dependencies/history_dependency.dart'; // Import History Dependency (using GetIt)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kDebugMode) {
    print('Memulai inisialisasi Firebase...');
  }
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
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
        ...provideHistoryDependencies(),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(), // Inisialisasi NavigationCubit
        ),
        // Tambahkan cubit atau provider lainnya jika diperlukan
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portfolio App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LandingPage(), // Halaman utama setelah login berhasil
        routes: {
          '/login': (context) => const LoginPage(), // Route untuk halaman login
          '/landing': (context) => const LandingPage(), // Route untuk landing_page
          '/projectTable': (context) => const ProjectTable(),// Tambahkan route lain jika diperlukan
        },
      ),
    );
  }
}
