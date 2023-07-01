// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'pdf_view_state.g.dart';

@match
enum PdfViewStatus {
  initial,
  loading,
  loaded,
  error,
}

class PdfViewState extends Equatable {
  final PdfViewStatus status;
  final File? file;
  final String? errorMessage;

  const PdfViewState({
    required this.status,
    this.file,
    this.errorMessage,
  });

  const PdfViewState.initial()
      : status = PdfViewStatus.initial,
        file = null,
        errorMessage = null;

  @override
  List<Object?> get props => [status, file, errorMessage];

  PdfViewState copyWith({
    PdfViewStatus? status,
    File? file,
    String? errorMessage,
  }) {
    return PdfViewState(
      status: status ?? this.status,
      file: file ?? this.file,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
