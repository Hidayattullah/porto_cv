import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationState { homesec, aboutsec, projectsec, contactsec }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.homesec);

  // Metode-metode ini bisa digunakan di tempat yang diperlukan
  void navigateToshowHomeSec() => emit(NavigationState.homesec);
  void navigateToshowAboutSec() => emit(NavigationState.aboutsec);
  void navigateToshowProjectSec() => emit(NavigationState.projectsec);
  void navigateToshowContactSec() => emit(NavigationState.contactsec);
}
