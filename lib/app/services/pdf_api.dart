import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../core/exceptions/pdf_api_exception.dart';
import '../repositories/storage/storage_firebase.dart';

class PDFApi {
  final FirebaseStorage _storage = StorageFirebase.instance;

  Future<File> _storeFile(String url, Uint8List bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<File> pickFileTermos() async {
    try {
      final refPDF = _storage
          .ref('/docs')
          .child('Termos de Uso A de Adote (Visão Celular).pdf');
      final bytes = await refPDF.getData();
      final selectedTermos = await _storeFile('termosUso', bytes!);
      return selectedTermos;
    } on PlatformException catch (e, s) {
      log(e.message ?? 'Erro desconhecido', error: e, stackTrace: s);
      throw PDFApiException(
          'Houve um problema. Por favor, tente novamente. Caso o problema persistir, envie um e-mail para: gustavo_henriquedepaula@hotmail.com.');
    }
  }

  Future<File> pickFilePolitica() async {
    try {
      final refPDF = _storage
          .ref('/docs')
          .child('Política de Privacidade A de Adote (Visão Celular).pdf');
      final bytes = await refPDF.getData();
      final selectedPolitica = await _storeFile('politicaPrivacidade', bytes!);
      return selectedPolitica;
    } on PlatformException catch (e, s) {
      log(e.message ?? 'Erro desconhecido', error: e, stackTrace: s);
      throw PDFApiException(
          'Houve um problema. Por favor, tente novamente. Caso o problema persistir, envie um e-mail para: gustavo_henriquedepaula@hotmail.com.');
    }
  }
}
