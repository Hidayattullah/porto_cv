import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/experience/experience_cubit.dart';
import 'experience_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'experience_body.dart';

class ExperienceSec extends StatefulWidget {
  const ExperienceSec({super.key});

  @override
  _ExperienceSecState createState() => _ExperienceSecState();
}

class _ExperienceSecState extends State<ExperienceSec> {
  late final FirebaseAuth _auth;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

    _auth.authStateChanges().listen((User? user) {
      if (!mounted) return;
      setState(() {
        _user = user;
      });

      if (user == null) {
        context.read<ExperienceCubit>().fetchExperiences();
      }
    });

    context.read<ExperienceCubit>().fetchExperiences();
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Mengatur padding dan ukuran font yang responsif berdasarkan ukuran layar
    final double horizontalPadding = screenWidth > 600 ? 50.0 : 20.0; // Lebih kecil di mobile
    final double verticalPadding = screenWidth > 600 ? 40.0 : 20.0;   // Lebih kecil di mobile
    // final double fontSize = screenWidth > 600 ? 20.0 : 16.0;          // Lebih kecil di mobile

    return Scaffold(
      appBar: AppBar(
        title: const Text('Experience Section'),
        actions: [
          if (_user != null)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ExperienceForm(
                    onAddExperience: (newExperience) { 
                      context.read<ExperienceCubit>().addNewExperience(newExperience);
                    },
                  ),
                );
              },
            ),
        ],
      ),
      body: Container(
        height: screenHeight, // Menjamin setiap section mengambil tinggi penuh layar
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ExperienceListBody(), // Daftar pengalaman kerja
            ),
          ],
        ),
      ),
    );
  }
}
