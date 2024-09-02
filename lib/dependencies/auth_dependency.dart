// File: lib/dependencies/auth_dependencies.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../presentation/cubits/auth/auth_cubit.dart';

// Fungsi untuk menyediakan dependencies AuthCubit
List<BlocProvider> provideAuthDependencies() {
  final authRepository = AuthRepository(); // Inisialisasi AuthRepository

  return [
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(authRepository),
    ),
  ];
}
