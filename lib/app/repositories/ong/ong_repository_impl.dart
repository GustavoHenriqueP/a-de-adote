import 'dart:developer';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/exceptions/http_request_exception.dart';
import 'package:a_de_adote/app/repositories/database/cache_control.dart';
import 'package:a_de_adote/app/repositories/database/db_firestore.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:a_de_adote/app/core/rest_client/custom_dio.dart';
import '../../core/exceptions/firestore_exception.dart';
import '../../models/ong_model.dart';
import 'ong_repository.dart';

class OngRepositoryImpl implements OngRepository {
  final CustomDio dio;
  final AuthService auth;
  final CacheControl cacheControl;
  late FirebaseFirestore db;

  OngRepositoryImpl({
    required this.dio,
    required this.auth,
    required this.cacheControl,
  }) {
    _startFirestore();
  }

  _startFirestore() {
    db = DbFirestore.instance;
  }

  @override
  Future<bool> verifyCnpjDuplicity(String cnpj) async {
    final snapshot =
        await db.collection('ong').where('cnpj', isEqualTo: cnpj).get();
    if (snapshot.docs.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<OngModel> getOngDataFromWeb(String cnpj) async {
    try {
      final result = await dio.get('https://receitaws.com.br/v1/cnpj/$cnpj');
      if (result.data['situacao'] == 'ATIVA' &&
          result.data['status'] != 'ERROR') {
        return OngModel.fromMap(result.data);
      } else if (result.data['situacao'] != 'ATIVA' &&
          result.data['status'] != 'ERROR') {
        throw Exception(Labels.cnpjInapto);
      } else {
        throw Exception(Labels.cnpjNaoEncontrado);
      }
    } on DioException catch (e) {
      log(Labels.erroCnpj, error: e);
      if (e.response?.statusCode == 429) {
        return throw Exception(Labels.servidoresOcupados);
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return throw Exception(Labels.timeout);
      }
      if (e.type == DioExceptionType.unknown) {
        return throw Exception(Labels.erroCnpj);
      }
      rethrow;
    }
  }

  @override
  Future<void> saveAcceptanceInfo(String? id) async {
    Map<String, dynamic> info;

    DateTime date = DateTime.now();

    final snapshot = await db.collection('variaveis').get();
    final int termsVersion = snapshot.docs.first.data()['termsVersion'];
    final int policyVersion = snapshot.docs.first.data()['policyVersion'];

    try {
      final response = await dio.get('https://api.ipify.org');
      final String userIp = response.data.toString();
      info = {
        'date': date,
        'termsVersion': termsVersion,
        'policyVersion': policyVersion,
        'userIp': userIp,
      };
    } on DioException catch (e, s) {
      log(e.message ?? 'Houve um erro ao buscar o IP', error: e, stackTrace: s);
      throw HttpRequestException('Houve um erro ao buscar o IP');
    }
    await db.collection('aceite_usuarios').doc(id).set(info);
  }

  @override
  Future<void> createOng(OngModel ong) async {
    try {
      await db.collection('ong').doc(ong.id).set(ong.toMap());
      await saveAcceptanceInfo(ong.id);
    } on FirebaseException catch (e, s) {
      log(Labels.erroDocOng, error: e, stackTrace: s);
      throw FirestoreException(Labels.erroCadastro);
    }
  }

  @override
  Future<List<OngModel>> getOngs({required bool refresh}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot;

      if (!refresh) {
        final bool updateCache = await cacheControl.canUpdateCacheOngs();
        if (!updateCache) {
          snapshot = await db
              .collection('ong')
              .get(const GetOptions(source: Source.cache));
        } else {
          snapshot = await db.collection('ong').get();
        }
      } else {
        snapshot = await db.collection('ong').get();
        if (snapshot.metadata.isFromCache) {
          throw FirestoreException(
              'Não foi possível atualizar as informações. Verifique sua conexão à internet.');
        }
      }

      if (snapshot.docs.isEmpty) {
        snapshot = await db.collection('ong').get();
      }

      List<OngModel> ongs = snapshot.docs
          .map(
            (ong) => OngModel.fromMap(ong.data()),
          )
          .toList();
      return ongs;
    } on FirebaseException catch (e, s) {
      log('Ocorreu um erro ao carregar as ONGs', error: e, stackTrace: s);
      throw FirestoreException('Ocorreu um erro ao carregar as ONGs');
    }
  }

  @override
  Future<OngModel> getOngById(String id) async {
    try {
      final snapshot = await db.collection('ong').doc(id).get();
      if (snapshot.exists) {
        final ong = OngModel.fromMap(snapshot.data()!);
        return ong;
      } else {
        throw FirestoreException(Labels.ongNaoEncontrada);
      }
    } on FirebaseException catch (e, s) {
      log('Ocorreu um erro ao pesquisar a ONG.', error: e, stackTrace: s);
      throw FirestoreException('Ocorreu um erro ao pesquisar a ONG.');
    }
  }

  @override
  Future<OngModel> getCurrentOngUser() async {
    try {
      if (auth.ongUser != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot;
        snapshot = await db
            .collection('ong')
            .doc(auth.ongUser!.uid)
            .get(const GetOptions(source: Source.cache));
        if (snapshot.data() == null) {
          log('Indo para o servidor...');
          snapshot = await db.collection('ong').doc(auth.ongUser!.uid).get();
        }

        final currentOngUser = OngModel.fromMap(snapshot.data()!);
        return currentOngUser;
      } else {
        throw FirestoreException(Labels.ongNaoEncontrada);
      }
    } on FirebaseException catch (e, s) {
      log('Ocorreu um erro ao pesquisar a ONG.', error: e, stackTrace: s);
      throw FirestoreException('Ocorreu um erro ao pesquisar a ONG.');
    }
  }

  @override
  Future<void> updateOng(OngModel ong) async {
    try {
      await db.collection('ong').doc(ong.id).update(ong.toMap());
    } on FirebaseException catch (e, s) {
      log(Labels.erroUpdateOng, error: e, stackTrace: s);
      throw FirestoreException(Labels.erroUpdateOng);
    }
  }

  @override
  Future<void> deleteOng(String? id) async {
    try {
      if (id != null) {
        await db.collection('ong').doc(id).delete();
      }
    } on FirebaseException catch (e, s) {
      log(Labels.erroUpdateOng, error: e, stackTrace: s);
      throw FirestoreException(Labels.erroUpdateOng);
    }
  }
}
