import 'package:flutter_bloc/flutter_bloc.dart';

// Menggunakan int untuk state navigasi (0: Home, 1: About, 2: Projects, 3: Contact)
class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0); // Mulai dari halaman Home (index 0)

  void navigateToSection(int index) => emit(index);

  // Metode-metode ini bisa digunakan di tempat yang diperlukan
  void showHomePage() => emit(0);
  void showAboutusPage() => emit(1);
  void showProjectPage() => emit(2);
  void showContactPage() => emit(3);
}
