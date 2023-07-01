// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_view_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PdfViewStatusMatch on PdfViewStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == PdfViewStatus.initial) {
      return initial();
    }

    if (v == PdfViewStatus.loading) {
      return loading();
    }

    if (v == PdfViewStatus.loaded) {
      return loaded();
    }

    if (v == PdfViewStatus.error) {
      return error();
    }

    throw Exception('PdfViewStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == PdfViewStatus.initial && initial != null) {
      return initial();
    }

    if (v == PdfViewStatus.loading && loading != null) {
      return loading();
    }

    if (v == PdfViewStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == PdfViewStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
