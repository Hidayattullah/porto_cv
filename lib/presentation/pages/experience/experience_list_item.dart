import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/experience_entity.dart';
import '../../cubits/experience/experience_cubit.dart';
import 'experience_update.dart';

class ExperienceListItem extends StatefulWidget {
  final ExperienceEntity experience;

  const ExperienceListItem({required this.experience, super.key});

  @override
  _ExperienceListItemState createState() => _ExperienceListItemState();
}

class _ExperienceListItemState extends State<ExperienceListItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    // Gunakan nilai string langsung dari entity, atau gunakan nilai default jika null
    final String startDate = widget.experience.startDate;
    final String endDate = widget.experience.endDate;

    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovering = true;
      }),
      onExit: (_) => setState(() {
        _isHovering = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: _isHovering ? Colors.white : Colors.grey[100], // Warna berubah saat hover
          borderRadius: BorderRadius.circular(5),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // Bayangan saat hover
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [], // Tidak ada bayangan saat tidak hover
        ),
        child: ListTile(
          onTap: () {
            // Example: Navigator.pushNamed(context, '/experienceDetail', arguments: widget.experience);
          },
          title: Text(
            widget.experience.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          subtitle: Text(
            "${widget.experience.description}\n"
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
                            experience: widget.experience,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<ExperienceCubit>().deleteExistingExperience(widget.experience.id);
                      },
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
