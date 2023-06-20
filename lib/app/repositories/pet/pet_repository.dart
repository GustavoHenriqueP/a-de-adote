import '../../models/pet_model.dart';

abstract class PetRepository {
  String generateIdPet(String imageUrl);
  Future<List<PetModel>> getPets({required bool refresh});
  Future<List<PetModel>> getCurrentUserPets();
  Future<void> createPet(PetModel pet);
  Future<void> updatePet(PetModel pet);
  Future<void> deletePet(PetModel pet);
}
