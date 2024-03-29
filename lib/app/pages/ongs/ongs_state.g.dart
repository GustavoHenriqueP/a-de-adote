// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongs_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension OngsStatusMatch on OngsStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() refreshing,
      required T Function() loaded,
      required T Function() loadedSearched,
      required T Function() loadedFiltered,
      required T Function() error}) {
    final v = this;
    if (v == OngsStatus.initial) {
      return initial();
    }

    if (v == OngsStatus.loading) {
      return loading();
    }

    if (v == OngsStatus.refreshing) {
      return refreshing();
    }

    if (v == OngsStatus.loaded) {
      return loaded();
    }

    if (v == OngsStatus.loadedSearched) {
      return loadedSearched();
    }

    if (v == OngsStatus.loadedFiltered) {
      return loadedFiltered();
    }

    if (v == OngsStatus.error) {
      return error();
    }

    throw Exception('OngsStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? refreshing,
      T Function()? loaded,
      T Function()? loadedSearched,
      T Function()? loadedFiltered,
      T Function()? error}) {
    final v = this;
    if (v == OngsStatus.initial && initial != null) {
      return initial();
    }

    if (v == OngsStatus.loading && loading != null) {
      return loading();
    }

    if (v == OngsStatus.refreshing && refreshing != null) {
      return refreshing();
    }

    if (v == OngsStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == OngsStatus.loadedSearched && loadedSearched != null) {
      return loadedSearched();
    }

    if (v == OngsStatus.loadedFiltered && loadedFiltered != null) {
      return loadedFiltered();
    }

    if (v == OngsStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
