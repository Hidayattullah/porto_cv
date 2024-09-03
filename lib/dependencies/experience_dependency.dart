// File: lib/dependencies/experience_dependency.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/experience_repository_impl.dart';
import '../domain/usercases/experience/add_experience.dart';
import '../domain/usercases/experience/delete_experience.dart';
import '../domain/usercases/experience/get_experience.dart';
import '../domain/usercases/experience/update_experience.dart';
import '../presentation/cubits/experience/experience_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<BlocProvider> provideExperienceDependencies() {
  final firestore = FirebaseFirestore.instance;
  final experienceRepository = ExperienceRepositoryImpl(firestore);

  return [
    BlocProvider<ExperienceCubit>(
      create: (context) => ExperienceCubit(
        getExperience: GetExperiences(experienceRepository),
        addExperience: AddExperience(experienceRepository),
        updateExperience: UpdateExperience(experienceRepository),
        deleteExperience: DeleteExperience(experienceRepository),
      ),
    ),
  ];
}
