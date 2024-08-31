import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// State ketika aplikasi baru saja dimulai dan belum ada otentikasi
class AuthInitial extends AuthState {}

// State ketika pengguna sedang diautentikasi
class AuthLoading extends AuthState {}

// State ketika otentikasi berhasil dan pengguna berhasil login
class AuthAuthenticated extends AuthState {
  final String email;

  const AuthAuthenticated(this.email);

  @override
  List<Object> get props => [email];
}

// State ketika otentikasi gagal atau pengguna tidak login
class AuthUnauthenticated extends AuthState {}

// State ketika terjadi error selama proses otentikasi
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
