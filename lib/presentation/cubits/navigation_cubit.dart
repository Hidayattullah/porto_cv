import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void navigateTo(int index) => emit(index);
  void showHomePage() => emit(0);
  void showAboutPage() => emit(1);
  void showProjectPage() => emit(2);
  void showContactPage() => emit(3);
}
