import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porto_cv/firebase_options.dart';
import 'presentation/cubits/auth/auth_cubit.dart';
import 'presentation/cubits/navigation/navigation_cubit.dart'; // Import NavigationCubit
import 'data/repositories/auth_repository.dart';
import 'presentation/pages/auth/login.dart';
import 'presentation/pages/landing_page.dart';

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

  final authRepository = AuthRepository(); // Inisialisasi AuthRepository

  runApp(
    MyApp(authRepository: authRepository),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({required this.authRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepository),
        ),
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
          // Tambahkan route lain jika diperlukan
        },
      ),
    );
  }
}
