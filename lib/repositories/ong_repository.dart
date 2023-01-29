import 'package:a_de_adote/models/ong_model.dart';

abstract class OngRepository {
  Future<OngModel> getOng(String cnpj);
}