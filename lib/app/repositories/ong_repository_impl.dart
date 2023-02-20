import 'dart:developer';
import 'package:a_de_adote/app/core/rest_client/custom_dio.dart';
import 'package:dio/dio.dart';
import '../models/ong_model.dart';
import 'ong_repository.dart';

class OngRepositoryImpl implements OngRepository {
  final CustomDio dio = CustomDio();

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
            'CNPJ com situação inapta. Por favor, insira um CNPJ ativo.');
      } else {
        throw Exception('CNPJ não encontrado.');
      }
    } catch (e) {
      log('Erro ao buscar CNPJ', error: e);
      if (e is DioError) {
        if (e.type == DioErrorType.badResponse) {
          return throw Exception(
              'Servidores ocupados. Tente novamente daqui 1 min.');
        }
        if (e.type == DioErrorType.connectionTimeout ||
            e.type == DioErrorType.sendTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          return throw Exception('Tempo de busca excedido. Tente novamente.');
        }
        if (e.type == DioErrorType.unknown) {
          return throw Exception('Erro ao buscar CNPJ.');
        }
      }
      rethrow;
    }
  }
}
