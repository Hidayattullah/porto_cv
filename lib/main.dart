import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/cubits/navigation_cubit.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/about_page.dart';
import 'presentation/pages/project_page.dart';
import 'presentation/pages/contact_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        // Tambahkan provider lain jika ada
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portfolio Website',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<NavigationCubit, int>(
          builder: (context, state) {
            switch (state) {
              case 1:
                return AboutPage();
              case 2:
                return ProjectPage();
              case 3:
                return ContactPage();
              default:
                return const HomePage();
            }
          },
        ),
      ),
    );
  }
}
