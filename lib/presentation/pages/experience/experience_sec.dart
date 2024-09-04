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
                    onAddExperience: (newExperience) { // Ubah dari onSubmit ke onAddExperience
                      context.read<ExperienceCubit>().addNewExperience(newExperience);
                    },
                  ),
                );
              },
            ),
        ],
      ),
      body: const ExperienceListBody(),
    );
  }
}
