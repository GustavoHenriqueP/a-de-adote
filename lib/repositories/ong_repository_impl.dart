import 'dart:developer';
import 'package:a_de_adote/models/ong_model.dart';
import 'package:dio/dio.dart';
import 'ong_repository.dart';

//TODO Tratar execções corretamente
class OngRepositoryImpl implements OngRepository {
  @override
  Future<OngModel> getOng(String cnpj) async {
    try {
      final result = await Dio().get('https://receitaws.com.br/v1/cnpj/$cnpj');
      if (result.data['status'] != 'ERROR' || result.statusCode != 404) {
        return OngModel.fromMap(result.data);
      }
      return throw Exception('Erro ao buscar CNPJ');
    } on DioError catch (e) {
      log('Erro ao buscar CNPJ', error: e);
      if (e.error == DioErrorType.response) {
        throw Exception('Servidores ocupados. Tente novamente daqui 1 min');
      }
      if (e.error == DioErrorType.connectTimeout ||
          e.error == DioErrorType.sendTimeout ||
          e.error == DioErrorType.receiveTimeout) {
        throw Exception('Tempo de busca excedido. Tente novamente mais tarde');
      }
      throw Exception('Erro ao buscar CNPJ');
    }
  }
}
