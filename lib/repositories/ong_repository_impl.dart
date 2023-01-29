import 'dart:developer';

import 'package:a_de_adote/models/ong_model.dart';
import 'package:dio/dio.dart';

import 'ong_repository.dart';

class OngRepositoryImpl implements OngRepository {
  @override
  Future<OngModel> getOng(String cnpj) async {
    try {
      final result = await Dio().get('https://receitaws.com.br/v1/cnpj/$cnpj');
      return OngModel.fromJson(result.data);
    } catch (e) {
      log('Erro ao buscar CNPJ', error: e);
      throw Exception('Erro ao buscar CNPJ');
    }
  }
}
