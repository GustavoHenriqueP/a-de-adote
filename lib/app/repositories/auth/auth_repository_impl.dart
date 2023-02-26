import 'dart:developer';

import 'package:a_de_adote/app/repositories/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthRepositoryImpl extends AuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<auth.User?> signUp(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      return user;
    } on auth.FirebaseAuthException catch (e, s) {
      log('Erro ao cadastrar', error: e, stackTrace: s);
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está em uso.');
      } else if (e.code == 'invalid-email') {
        throw AuthException('E-mail inválido.');
      }
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (e, s) {
      log('Erro ao logar', error: e, stackTrace: s);
      if (e.code == 'user-not-found') {
        throw AuthException('E-mail não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente.');
      }
    }
  }

  // @override
  // Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  auth.User? get user => _firebaseAuth.currentUser;

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
