import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:bloc/bloc.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_animals/ong_animals_state.dart';
import 'package:a_de_adote/app/repositories/pet/pet_repository.dart';
import 'package:flutter/foundation.dart';

class OngAnimalsController extends Cubit<OngAnimalsState> {
  final PetRepository _petRepository;

  OngAnimalsController(
    this._petRepository,
  ) : super(OngAnimalsState.initial());

  Future<void> loadCurrentUserPets() async {
    try {
      emit(state.copyWith(status: OngAnimalStatus.loading));
      final listPets = await _petRepository.getCurrentUserPets();
      emit(
        state.copyWith(
          status: OngAnimalStatus.loaded,
          listPets: listPets,
        ),
      );
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: OngAnimalStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> deletePet(PetModel pet) async {
    try {
      await _petRepository.deletePet(pet);
      emit(state.copyWith(status: OngAnimalStatus.petDeleted));
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: OngAnimalStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  void loadPetsSearched(String option) {
    emit(state.copyWith(status: OngAnimalStatus.loading));
    if (option == '') {
      emit(
        state.copyWith(
          status: OngAnimalStatus.error,
          errorMessage: 'Por favor, digite um nome.',
        ),
      );
    } else {
      final listPetsSearched = state.listPets.where((pet) {
        if (pet.nome != null) {
          bool testName = pet.nome?.toLowerCase() == option.toLowerCase();
          if (testName) {
            return testName;
          } else {
            if (pet.idMicrochip != null) {
              return pet.idMicrochip?.toLowerCase() == option.toLowerCase();
            }
          }
        } else if (pet.idMicrochip != null) {
          return pet.idMicrochip?.toLowerCase() == option.toLowerCase();
        }

        return false;
      }).toList();
      if (listPetsSearched.isNotEmpty) {
        emit(
          state.copyWith(
            status: OngAnimalStatus.loadedSearched,
            listPetsSearched: listPetsSearched,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: OngAnimalStatus.error,
            errorMessage: 'Não foi encontrado nenhum animal.',
          ),
        );
      }
    }
  }

  void loadPetsFiltered(Map<String, dynamic>? filters) {
    if (filters == null) {
      clearPetsFiltered();
      return;
    }

    final Map<String, dynamic> defaultFilters = {
      'ong': 'Todas',
      'dog': false,
      'cat': false,
      'bird': false,
      'other': false,
      'idadeMaxima': 20,
      'sexo': 0,
      'mini': false,
      'pequeno': false,
      'medio': false,
      'grande': false,
    };

    if (mapEquals(filters, defaultFilters)) {
      clearPetsFiltered();
      return;
    }

    List<PetModel> currentList = state.listPetsSearched.isNotEmpty
        ? state.listPetsSearched
        : state.listPets;
    List<PetModel> newListFiltered = currentList.where(
      (pet) {
        if ((filters['dog'] == false) &&
            (filters['cat'] == false) &&
            (filters['bird'] == false) &&
            (filters['other'] == false)) {
          return true;
        }

        return (filters['dog'] ? pet.especie == 'Cachorro' : false) ||
            (filters['cat'] ? pet.especie == 'Gato' : false) ||
            (filters['bird'] ? pet.especie == 'Pássaro' : false) ||
            (filters['other'] ? pet.especie == 'Outro' : false);
      },
    ).where(
      (pet) {
        if (pet.idadeAproximada
                .replaceAll(RegExp('[0-9]'), '')
                .replaceAll(' ', '') ==
            'meses') {
          return true;
        }
        return int.parse(
              pet.idadeAproximada.replaceAll(RegExp(r'[^0-9]'), ''),
            ) <=
            filters['idadeMaxima'];
      },
    ).where(
      (pet) {
        if (filters['sexo'] == 1) {
          return pet.sexo == 'Masculino';
        } else if (filters['sexo'] == 2) {
          return pet.sexo == 'Feminino';
        } else {
          return true;
        }
      },
    ).where(
      (pet) {
        if ((filters['mini'] == false) &&
            (filters['pequeno'] == false) &&
            (filters['medio'] == false) &&
            (filters['grande'] == false)) {
          return true;
        }

        return (filters['mini'] ? pet.porte == 'Mini' : false) ||
            (filters['pequeno'] ? pet.porte == 'Pequeno' : false) ||
            (filters['medio'] ? pet.porte == 'Médio' : false) ||
            (filters['grande'] ? pet.porte == 'Grande' : false);
      },
    ).toList();

    if (newListFiltered.isNotEmpty) {
      emit(
        state.copyWith(
          status: OngAnimalStatus.loadedFiltered,
          listPetsFiltered: newListFiltered,
          currentFilters: filters,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: OngAnimalStatus.error,
          errorMessage: 'Não foi possível encontrar nenhum animal.',
        ),
      );
    }
  }

  void clearPetsSearched() {
    state.listPetsSearched = [];
    emit(state.copyWith(status: OngAnimalStatus.loaded));
  }

  void clearPetsFiltered() {
    state.listPetsFiltered = [];
    state.currentFilters = null;
    emit(
      state.copyWith(status: OngAnimalStatus.loaded),
    );
  }
}
