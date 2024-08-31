import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // Fungsi untuk login menggunakan email dan password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      if (kDebugMode) {
        print('Trying to sign in with email: $email');
      }
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print('Successfully signed in as ${userCredential.user?.email}');
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      } else {
        if (kDebugMode) {
          print('Error during signInWithEmailAndPassword: ${e.message}');
        }
      }
      return null;
    }
  }

  // Fungsi untuk mendaftarkan pengguna baru menggunakan email dan password
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      if (kDebugMode) {
        print('Trying to register with email: $email');
      }
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print('Successfully registered as ${userCredential.user?.email}');
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Error during registerWithEmailAndPassword: $e');
      }
      // Tangani error spesifik di sini jika diperlukan
      return null;
    }
  }

  // Fungsi untuk logout
  Future<void> signOut() async {
    if (kDebugMode) {
      print('Attempting to sign out.');
    }
    await _firebaseAuth.signOut();
    if (kDebugMode) {
      print('Successfully signed out.');
    }
  }

  // Fungsi untuk mendapatkan status login saat ini
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (kDebugMode) {
      print('Current user: ${user?.email}');
    }
    return user;
  }

  // Fungsi untuk mendengarkan perubahan pada status otentikasi
  Stream<User?> authStateChanges() {
    if (kDebugMode) {
      print('Listening to auth state changes.');
    }
    return _firebaseAuth.authStateChanges();
  }
}
