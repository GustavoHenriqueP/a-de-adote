import 'dart:io';
import 'package:a_de_adote/app/core/exceptions/pdf_api_exception.dart';
import 'package:a_de_adote/app/pages/ong_register/pdf_view/pdf_view_state.dart';
import 'package:a_de_adote/app/services/pdf_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdfViewController extends Cubit<PdfViewState> {
  final PDFApi _pdfApi;

  PdfViewController(
    this._pdfApi,
  ) : super(const PdfViewState.initial());

  Future<void> getDocument(String documentType) async {
    try {
      emit(state.copyWith(status: PdfViewStatus.loading));
      final File? document;
      if (documentType == 'termos') {
        document = await _pdfApi.pickFileTermos();
      } else if (documentType == 'politica') {
        document = await _pdfApi.pickFilePolitica();
      } else {
        document = null;
      }
      emit(
        state.copyWith(
          status: PdfViewStatus.loaded,
          file: document,
        ),
      );
    } on PDFApiException catch (e) {
      emit(
        state.copyWith(
          status: PdfViewStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
