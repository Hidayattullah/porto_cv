import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/experience_entity.dart';
import '../../cubits/experience/experience_cubit.dart';
import 'experience_update.dart';

class ExperienceListItem extends StatelessWidget {
  final ExperienceEntity experience;

  const ExperienceListItem({required this.experience, super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    // Gunakan nilai string langsung dari entity, atau gunakan nilai default jika null
    final String startDate = experience.startDate;
    final String endDate = experience.endDate;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        onTap: () {
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
          "Start Date: $startDate\n"
          "End Date: $endDate",
        ),
        trailing: user != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ExperienceListUpdate(
                          experience: experience,
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
  }
}
