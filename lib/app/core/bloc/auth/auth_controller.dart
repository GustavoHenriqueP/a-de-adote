import 'dart:async';
import 'dart:developer';
import 'package:a_de_adote/app/core/bloc/auth/auth_state.dart';
import 'package:a_de_adote/app/models/ong_model.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:bloc/bloc.dart';

import '../../../repositories/auth/auth_repository.dart';

class AuthController extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final OngRepository _ongRepository;

  AuthController(
    this._authRepository,
    this._ongRepository,
  ) : super(const AuthState.initial());

  Future<void> signUpOng(OngModel ong, String password) async {
    try {
      final ongUser = await _authRepository.signUp(
        email: ong.email,
        password: password,
      );
      final ongModel = ong.copyWith(id: ongUser?.uid);
      await _ongRepository.createOng(ongModel);
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          authUser: ongUser,
          ongModel: ongModel,
        ),
      );
    } catch (e, s) {
      log('Erro ao cadastrar ONG', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> loginOng(String email, String password) async {
    try {
      await _authRepository.login(email: email, password: password);
      log('Acesso permitido.');
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          authUser: _authRepository.user,
          ongModel: await _ongRepository.getOng(_authRepository.user!.uid).last,
        ),
      );
    } catch (e, s) {
      log('Erro ao logar.', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> signOutOng() async {
    await _authRepository.signOut();
    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      authUser: null,
      ongModel: null,
    ));
  }
}
