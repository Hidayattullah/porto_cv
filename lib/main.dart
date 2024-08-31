import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'presentation/cubits/auth/auth_cubit.dart';
import 'presentation/cubits/navigation/navigation_cubit.dart';
import 'presentation/pages/auth/login.dart';
import 'presentation/pages/landing_page.dart';
import 'firebase_options.dart'; // Import file konfigurasi Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Menggunakan opsi konfigurasi platform yang sesuai
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => AuthCubit()), // Menambahkan AuthCubit
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portfolio Website',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LandingPage(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
