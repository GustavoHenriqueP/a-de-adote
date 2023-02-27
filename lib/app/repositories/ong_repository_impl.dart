// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:a_de_adote/app/core/rest_client/custom_dio.dart';

import '../core/constantes/labels.dart';
import '../models/ong_model.dart';
import 'ong_repository.dart';

class OngRepositoryImpl implements OngRepository {
  final CustomDio dio;

  OngRepositoryImpl({
    required this.dio,
  });

  @override
  Future<OngModel> getOng(String cnpj) async {
    try {
      final result = await dio.get('https://receitaws.com.br/v1/cnpj/$cnpj');
      if (result.data['situacao'] == 'ATIVA' &&
          result.data['status'] != 'ERROR') {
        return OngModel.fromMap(result.data);
      } else if (result.data['situacao'] != 'ATIVA' &&
          result.data['status'] != 'ERROR') {
        throw Exception(
            Labels.cnpjInapto);
      } else {
        throw Exception(Labels.cnpjNaoEncontrado);
      }
    } on DioError catch (e) {
      log(Labels.erroCnpj, error: e);
      if (e.response?.statusCode == 429) {
        return throw Exception(
            Labels.servidoresOcupados);
      }
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        return throw Exception(Labels.timeout);
      }
      if (e.type == DioErrorType.unknown) {
        return throw Exception(Labels.erroCnpj);
      }
      rethrow;
    }
  }
}
