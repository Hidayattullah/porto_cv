// File: lib/presentation/cubits/experience/experience_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/experience_entity.dart';
import '../../../domain/usercases/experience/add_experience.dart';
import '../../../domain/usercases/experience/delete_experience.dart';
import '../../../domain/usercases/experience/update_experience.dart';
import '../../../domain/usercases/experience/get_experience.dart';
import 'experience_state.dart';

class ExperienceCubit extends Cubit<ExperienceState> {
  final GetExperiences getExperience;
  final AddExperience addExperience;
  final UpdateExperience updateExperience;
  final DeleteExperience deleteExperience;

  ExperienceCubit({
    required this.getExperience,
    required this.addExperience,
    required this.updateExperience,
    required this.deleteExperience,
  }) : super(ExperienceInitial());

  Future<void> fetchExperiences() async {
    try {
      emit(ExperienceLoading());
      final experiences = await getExperience();
      emit(ExperienceLoaded(experiences));
    } catch (e) {
      emit(ExperienceError('Failed to fetch experiences'));
    }
  }

  Future<void> addNewExperience(ExperienceEntity experience) async {
    try {
      await addExperience(experience);
      await fetchExperiences();
    } catch (e) {
      emit(ExperienceError('Failed to add experience'));
    }
  }

  Future<void> updateExistingExperience(ExperienceEntity experience) async {
    try {
      await updateExperience(experience);
      await fetchExperiences();
    } catch (e) {
      emit(ExperienceError('Failed to update experience'));
    }
  }

  Future<void> deleteExistingExperience(String experienceId) async {
    try {
      await deleteExperience(experienceId);
      await fetchExperiences();
    } catch (e) {
      emit(ExperienceError('Failed to delete experience'));
    }
  }
}
