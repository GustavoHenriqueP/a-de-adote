// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension AuthStatusMatch on AuthStatus {
  T match<T>(
      {required T Function() unknown,
      required T Function() authenticated,
      required T Function() unauthenticated,
      required T Function() error}) {
    final v = this;
    if (v == AuthStatus.unknown) {
      return unknown();
    }

    if (v == AuthStatus.authenticated) {
      return authenticated();
    }

    if (v == AuthStatus.unauthenticated) {
      return unauthenticated();
    }

    if (v == AuthStatus.error) {
      return error();
    }

    throw Exception('AuthStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? unknown,
      T Function()? authenticated,
      T Function()? unauthenticated,
      T Function()? error}) {
    final v = this;
    if (v == AuthStatus.unknown && unknown != null) {
      return unknown();
    }

    if (v == AuthStatus.authenticated && authenticated != null) {
      return authenticated();
    }

    if (v == AuthStatus.unauthenticated && unauthenticated != null) {
      return unauthenticated();
    }

    if (v == AuthStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
