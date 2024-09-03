import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/experience/experience_cubit.dart';
import '../../cubits/experience/experience_state.dart';
import '../../widgets/cards/ovalcard.dart';
import '../../../domain/entities/experience_entity.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:intl/intl.dart'; // Import untuk format tanggal

class ExperienceSec extends StatelessWidget {
  const ExperienceSec({super.key});

  String formatDate(DateTime date) {
    // Fungsi untuk memformat tanggal menjadi DDMMYYYY
    return DateFormat('ddMMyyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Mendapatkan user saat ini

    return Scaffold(
      appBar: AppBar(
        title: const Text('Experience Section'),
        actions: [
          if (user != null) // Tombol tambah hanya muncul jika user terautentikasi
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddExperienceDialog(context);
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
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: experiences.map((experience) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Dismissible(
                        key: Key(experience.id),
                        onDismissed: (direction) {
                          if (user != null) {
                            // Hanya user terautentikasi yang bisa menghapus
                            context
                                .read<ExperienceCubit>()
                                .deleteExistingExperience(experience.id);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Anda harus login untuk menghapus pengalaman.')),
                            );
                          }
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: OvalCard(
                          title: experience.title,
                          description: "${experience.description}\n"
                              "Start Date: ${formatDate(experience.startDate)}\n"
                              "End Date: ${experience.endDate != null ? formatDate(experience.endDate!) : 'N/A'}",
                          showButtons: user != null, // Menampilkan tombol update dan delete hanya jika user login
                          onUpdate: () {
                            // Logika untuk tombol update
                            _showUpdateExperienceDialog(context, experience);
                          },
                          onDelete: () {
                            // Logika untuk tombol delete
                            context.read<ExperienceCubit>().deleteExistingExperience(experience.id);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else if (state is ExperienceError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No experiences found.'));
          }
        },
      ),
    );
  }

  void _showAddExperienceDialog(BuildContext context) {
    final titleController = TextEditingController();
    final companyController = TextEditingController();
    final descriptionController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Experience'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Company'),
                ),
                TextField(
                  controller: startDateController,
                  decoration: const InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
                ),
                TextField(
                  controller: endDateController,
                  decoration: const InputDecoration(labelText: 'End Date (YYYY-MM-DD, optional)'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                final title = titleController.text;
                final company = companyController.text;
                final description = descriptionController.text;
                final startDate = DateTime.tryParse(startDateController.text);
                final endDate = endDateController.text.isNotEmpty
                    ? DateTime.tryParse(endDateController.text)
                    : null;

                if (title.isNotEmpty && company.isNotEmpty && startDate != null && description.isNotEmpty) {
                  final newExperience = ExperienceEntity(
                    id: '', // ID bisa digenerate saat menambah ke database
                    title: title,
                    company: company,
                    startDate: startDate,
                    endDate: endDate,
                    description: description,
                    tags: [], // Kosongkan atau isi dengan tags yang sesuai
                  );

                  // Menambah pengalaman baru melalui ExperienceCubit
                  context.read<ExperienceCubit>().addNewExperience(newExperience);
                  Navigator.of(context).pop(); // Tutup dialog setelah menambah
                } else {
                  // Tampilkan pesan kesalahan atau feedback ke user jika input tidak valid
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all required fields.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdateExperienceDialog(BuildContext context, ExperienceEntity experience) {
    final titleController = TextEditingController(text: experience.title);
    final companyController = TextEditingController(text: experience.company);
    final descriptionController = TextEditingController(text: experience.description);
    final startDateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(experience.startDate));
    final endDateController = TextEditingController(
        text: experience.endDate != null ? DateFormat('yyyy-MM-dd').format(experience.endDate!) : '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Experience'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Company'),
                ),
                TextField(
                  controller: startDateController,
                  decoration: const InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
                ),
                TextField(
                  controller: endDateController,
                  decoration: const InputDecoration(labelText: 'End Date (YYYY-MM-DD, optional)'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Update'),
              onPressed: () {
                final title = titleController.text;
                final company = companyController.text;
                final description = descriptionController.text;
                final startDate = DateTime.tryParse(startDateController.text);
                final endDate = endDateController.text.isNotEmpty
                    ? DateTime.tryParse(endDateController.text)
                    : null;

                if (title.isNotEmpty && company.isNotEmpty && startDate != null && description.isNotEmpty) {
                  final updatedExperience = ExperienceEntity(
                    id: experience.id, // ID pengalaman yang akan di-update
                    title: title,
                    company: company,
                    startDate: startDate,
                    endDate: endDate,
                    description: description,
                    tags: experience.tags, // Tetap menggunakan tags yang sudah ada
                  );

                  // Update pengalaman melalui ExperienceCubit
                  context.read<ExperienceCubit>().updateExistingExperience(updatedExperience);
                  Navigator.of(context).pop(); // Tutup dialog setelah update
                } else {
                  // Tampilkan pesan kesalahan atau feedback ke user jika input tidak valid
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all required fields.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
