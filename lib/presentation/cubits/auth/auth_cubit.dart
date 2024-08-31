import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial()) {
    _authRepository.authStateChanges().listen((user) {
      if (user != null) {
        emit(AuthAuthenticated(user.email!)); // Emit state dengan email pengguna
      } else {
        emit(AuthUnauthenticated()); // Emit state ketika tidak ada pengguna
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signInWithEmailAndPassword(email, password);
      if (user != null) {
        emit(AuthAuthenticated(user.email!)); // Emit state authenticated
      } else {
        emit(const AuthError('Login failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.registerWithEmailAndPassword(email, password);
      if (user != null) {
        emit(AuthAuthenticated(user.email!)); // Emit state authenticated
      } else {
        emit(const AuthError('Registration failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthUnauthenticated()); // Emit state unauthenticated
  }
}
