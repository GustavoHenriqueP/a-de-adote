import '../models/ong_model.dart';

abstract class OngRepository {
  Future<OngModel> getOng(String cnpj);
}
