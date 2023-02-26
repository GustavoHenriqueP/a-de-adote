import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class AuthRepository {
  auth.User? get user;
  Future<auth.User?> signUp({
    required String email,
    required String password,
  });
  Future<void> login({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
