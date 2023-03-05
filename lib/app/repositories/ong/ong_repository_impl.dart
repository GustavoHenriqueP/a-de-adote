import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:a_de_adote/app/core/rest_client/custom_dio.dart';
import '../../core/exceptions/firestore_exception.dart';
import '../../models/ong_model.dart';
import 'ong_repository.dart';

class OngRepositoryImpl implements OngRepository {
  final CustomDio dio;
  final FirebaseFirestore _firebaseFirestore;

  OngRepositoryImpl({
    required this.dio,
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<OngModel> getOngDataFromWeb(String cnpj) async {
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
    } on DioError catch (e) {
      log('Erro ao buscar CNPJ', error: e);
      if (e.response?.statusCode == 429) {
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
      rethrow;
    }
  }

  @override
  Future<void> createOng(OngModel ong) async {
    try {
      await _firebaseFirestore.collection('ong').doc(ong.id).set(ong.toMap());
    } on FirebaseException catch (e, s) {
      log('Erro ao criar documento ong', error: e, stackTrace: s);
      throw FirestoreException('Erro ao cadastrar.');
    }
  }

  @override
  Stream<OngModel> getOng(String ongId) {
    try {
      log('Getting user data from Cloud Firestore');
      return _firebaseFirestore
          .collection('ong')
          .doc(ongId)
          .snapshots()
          .map((snap) => OngModel.fromSnapshot(snap));
    } on FirebaseException catch (e, s) {
      log('Erro ao buscar documento ong', error: e, stackTrace: s);
      throw FirestoreException('Erro ao buscar Ong.');
    }
  }

  @override
  Future<void> updateOng(OngModel ong) async {
    try {
      return _firebaseFirestore
          .collection('ong')
          .doc(ong.id)
          .update(ong.toMap())
          .then(
            (_) => log('User document updated.'),
          );
    } on FirebaseException catch (e, s) {
      log('Erro ao atualizar documento ong', error: e, stackTrace: s);
      throw FirestoreException('Erro ao atualizar ong.');
    }
  }
}
