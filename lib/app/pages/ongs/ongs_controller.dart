import 'package:a_de_adote/app/models/ong_model.dart';
import 'package:a_de_adote/app/pages/ongs/ongs_state.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../core/exceptions/firestore_exception.dart';
import '../../core/ui/helpers/filters_state.dart';

class OngsController extends Cubit<OngsState> {
  final OngRepository _ongRepository;

  OngsController(
    this._ongRepository,
  ) : super(OngsState.initial());

  Future<void> loadAllOngs({required bool refresh}) async {
    try {
      refresh
          ? emit(state.copyWith(status: OngsStatus.refreshing))
          : emit(state.copyWith(status: OngsStatus.loading));
      final listOngs = await _ongRepository.getOngs(refresh: refresh);
      state.listOngs = listOngs;
      if (FiltersState.ongCurrentFilters == null) {
        emit(state.copyWith(status: OngsStatus.loaded));
      } else {
        loadOngsFiltered(FiltersState.ongCurrentFilters);
      }
    } on FirestoreException catch (e) {
      emit(
        state.copyWith(
          status: OngsStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  void loadOngsSearched(String option) {
    emit(state.copyWith(status: OngsStatus.loading));
    if (option == '') {
      emit(
        state.copyWith(
          status: OngsStatus.error,
          errorMessage: 'Por favor, digite um nome.',
        ),
      );
    } else {
      final listOngsSearched = state.listOngs
          .where((ong) => ong.fantasia.toLowerCase() == option.toLowerCase())
          .toList();
      if (listOngsSearched.isNotEmpty) {
        emit(
          state.copyWith(
            status: OngsStatus.loadedSearched,
            listOngsSearched: listOngsSearched,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: OngsStatus.error,
            errorMessage: 'Não foi encontrada nenhuma ong.',
          ),
        );
      }
    }
  }

  void loadOngsFiltered(Map<String, dynamic>? filters) {
    if (filters == null) {
      clearOngsFiltered();
      return;
    }

    final Map<String, dynamic> defaultFilters = {
      'municipio': 'Todos',
    };

    if (mapEquals(filters, defaultFilters)) {
      clearOngsFiltered();
      return;
    }

    List<OngModel> currentList = state.listOngsSearched.isNotEmpty
        ? state.listOngsSearched
        : state.listOngs;
    List<OngModel> newListFiltered = currentList.where(
      (ong) {
        if (filters['municipio'] != 'Todos') {
          return ong.municipio == filters['municipio'];
        }
        return true;
      },
    ).toList();

    if (newListFiltered.isNotEmpty) {
      emit(
        state.copyWith(
          status: OngsStatus.loadedFiltered,
          listOngsFiltered: newListFiltered,
          currentFilters: filters,
        ),
      );
    } else {
      FiltersState.ongCurrentFilters = FiltersState.tempOngFilters;
      emit(
        state.copyWith(
          status: OngsStatus.error,
          errorMessage: 'Não foi possível encontrar nenhuma ong.',
        ),
      );
    }
  }

  void clearOngsSearched() {
    state.listOngsSearched = [];
    emit(state.copyWith(status: OngsStatus.loaded));
  }

  void clearOngsFiltered() {
    state.listOngsFiltered = [];
    state.currentFilters = null;
    FiltersState.tempOngFilters = null;
    FiltersState.ongCurrentFilters = null;
    emit(
      state.copyWith(status: OngsStatus.loaded),
    );
  }
}
