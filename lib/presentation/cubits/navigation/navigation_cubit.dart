import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationState { homesec, experiencesec, projectsec, contactsec, historysec }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.homesec);

  void navigateToshowHomeSec() => emit(NavigationState.homesec);
  void navigateToshowExperienceSec() => emit(NavigationState.experiencesec);
  void navigateToshowProjectSec() => emit(NavigationState.projectsec);
  void navigateToshowContactSec() => emit(NavigationState.contactsec);
  void navigateToshowHistorySec() => emit(NavigationState.historysec);
}
