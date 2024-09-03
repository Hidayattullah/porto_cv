import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/experience/experience_cubit.dart';
import '../../cubits/experience/experience_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'experience_add.dart';
import 'experience_update.dart'; // Import dialog

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

    // Listener untuk perubahan status autentikasi
    _auth.authStateChanges().listen((User? user) {
      if (!mounted) return; // Cek apakah widget masih terpasang sebelum melakukan operasi UI
      setState(() {
        _user = user;
      });

      // Refresh data ketika user logout
      if (user == null) {
        context.read<ExperienceCubit>().fetchExperiences();
      }
    });

    // Memanggil fungsi untuk memuat data pengalaman saat widget pertama kali dibangun
    context.read<ExperienceCubit>().fetchExperiences();
  }

  String formatDate(DateTime date) {
    // Mengubah format tanggal menjadi ddMMyyyy
    return DateFormat('ddMMyyyy').format(date);
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
                  builder: (context) => AddExperienceDialog(
                    onAddExperience: (newExperience) {
                      context.read<ExperienceCubit>().addNewExperience(newExperience);
                    },
                  ),
                );
              },
            ),
        ],
      ),
      body: BlocBuilder<ExperienceCubit, ExperienceState>(
        builder: (context, state) {
          if (state is ExperienceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExperienceLoaded) {
            final experiences = state.experiences;
            if (experiences.isEmpty) {
              return const Center(child: Text('No experiences found.'));
            }
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: experiences.map((experience) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        onTap: () {
                          // Action on click, could be navigating to a detail page or opening a link
                          // Example: Navigator.pushNamed(context, '/experienceDetail', arguments: experience);
                        },
                        title: Text(
                          experience.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        subtitle: Text(
                          "${experience.description}\n"
                          "Start Date: ${formatDate(experience.startDate)}\n"
                          "End Date: ${experience.endDate != null ? formatDate(experience.endDate!) : 'Present'}",
                        ),
                        trailing: _user != null
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => UpdateExperienceDialog(
                                          experience: experience,
                                          onUpdateExperience: (updatedExperience) {
                                            context.read<ExperienceCubit>().updateExistingExperience(updatedExperience);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      context.read<ExperienceCubit>().deleteExistingExperience(experience.id);
                                    },
                                  ),
                                ],
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else if (state is ExperienceError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
