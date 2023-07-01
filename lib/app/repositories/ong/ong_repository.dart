import '../../models/ong_model.dart';

abstract class OngRepository {
  Future<bool> verifyCnpjDuplicity(String cnpj);
  Future<OngModel> getOngDataFromWeb(String cnpj);
  Future<List<OngModel>> getOngs({required bool refresh});
  Future<OngModel> getOngById(String id);
  Future<OngModel> getCurrentOngUser();
  Future<void> createOng(OngModel ong);
  Future<void> saveAcceptanceInfo(String id);
  Future<void> updateOng(OngModel ong);
  Future<void> deleteOng(String? id);
}
