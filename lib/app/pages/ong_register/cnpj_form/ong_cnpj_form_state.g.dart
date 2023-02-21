// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ong_cnpj_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension OngCnpjFormStatusMatch on OngCnpjFormStatus {
  T match<T>(
      {required T Function() inital,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == OngCnpjFormStatus.inital) {
      return inital();
    }

    if (v == OngCnpjFormStatus.loading) {
      return loading();
    }

    if (v == OngCnpjFormStatus.loaded) {
      return loaded();
    }

    if (v == OngCnpjFormStatus.error) {
      return error();
    }

    throw Exception(
        'OngCnpjFormStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? inital,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == OngCnpjFormStatus.inital && inital != null) {
      return inital();
    }

    if (v == OngCnpjFormStatus.loading && loading != null) {
      return loading();
    }

    if (v == OngCnpjFormStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == OngCnpjFormStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
