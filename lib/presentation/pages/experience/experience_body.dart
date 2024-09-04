import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/experience/experience_cubit.dart';
import '../../cubits/experience/experience_state.dart';
import 'experience_list_item.dart';

class ExperienceListBody extends StatelessWidget {
  const ExperienceListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExperienceCubit, ExperienceState>(
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
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white, // Warna latar belakang item
                      borderRadius: BorderRadius.circular(5.0), // Border radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Warna bayangan
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(2, 4), // Posisi bayangan
                        ),
                      ],
                    ),
                    child: ExperienceListItem(experience: experience),
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
    );
  }
}
