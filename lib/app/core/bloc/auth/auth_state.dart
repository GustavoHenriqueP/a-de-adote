// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:match/match.dart';

import '../../../models/ong_model.dart';

part 'auth_state.g.dart';

@match
enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final auth.User? authUser;
  final OngModel? ongModel;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.authUser,
    this.ongModel,
    this.errorMessage,
  });

  const AuthState.initial()
      : status = AuthStatus.unknown,
        authUser = null,
        ongModel = null,
        errorMessage = null;

  @override
  List<Object?> get props => [status, authUser, ongModel, errorMessage];

  AuthState copyWith({
    AuthStatus? status,
    auth.User? authUser,
    OngModel? ongModel,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      authUser: authUser ?? this.authUser,
      ongModel: ongModel ?? this.ongModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
