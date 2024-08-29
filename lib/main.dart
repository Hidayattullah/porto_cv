import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/cubits/navigation_cubit.dart';
import 'presentation/pages/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()), // Initialize SecnavCubit
   // Initialize ThemeCubit
        // Add other providers if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portfolio Website',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LandingPage(), // Use LandingPage as the home
      ),
    );
  }
}
