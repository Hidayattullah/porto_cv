// lib/presentation/cubits/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Contoh fungsi login
  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      // Simulasi proses login
      await Future.delayed(const Duration(seconds: 2));

      // Cek login dengan contoh statis
      if (email == 'user@example.com' && password == 'password123') {
        // Misalnya peran diambil dari respons server
        const role = 'user';
        emit(const AuthAuthenticated(role: role));
      } else {
        emit(const AuthError(message: 'Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Fungsi logout
  void signOut() {
    emit(AuthInitial());
  }
}
