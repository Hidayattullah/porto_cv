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
                  return ExperienceListItem(experience: experience);
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
