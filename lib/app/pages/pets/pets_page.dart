import 'dart:async';

import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/ui/helpers/bottom_sheet_pet_filter.dart';
import 'package:a_de_adote/app/core/ui/helpers/filters_state.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_shimmer_effect.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_sliver_appbar.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_sliver_search_bar.dart';
import 'package:a_de_adote/app/pages/pet_details/pet_details_router.dart';
import 'package:a_de_adote/app/pages/pets/pets_controller.dart';
import 'package:a_de_adote/app/pages/pets/pets_state.dart';
import 'package:a_de_adote/app/pages/pets/widgets/pet_card.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> with BottomSheetPetFilter {
  final ValueNotifier<bool> _isSearchBar = ValueNotifier(false);
  bool _isLoading = true;
  final ValueNotifier<bool> _loadShimmerEffect = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PetsController>().loadAllPets(refresh: false);
    });
  }

  @override
  void dispose() {
    _isSearchBar.dispose();
    _loadShimmerEffect.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isSearchBar.value == true) {
          context.read<PetsController>().clearPetsFiltered();
        }
        context.read<PetsController>().clearPetsSearched();
        _isSearchBar.value = false;
        return false;
      },
      child: Scaffold(
        drawer: const StandardDrawer(),
        body: ValueListenableBuilder(
          valueListenable: _isSearchBar,
          builder: (BuildContext context, bool isSearchBar, Widget? child) {
            return NestedScrollView(
              headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
                return [
                  isSearchBar
                      ? BlocBuilder<PetsController, PetsState>(
                          builder: (context, state) {
                            return StandardSliverSearchBar(
                              listaNomes: state.listPets
                                  .map((pet) => pet.nome)
                                  .toList(),
                              backButtonFunction: () {
                                context
                                    .read<PetsController>()
                                    .clearPetsFiltered();
                                context
                                    .read<PetsController>()
                                    .clearPetsSearched();
                                _isSearchBar.value = false;
                              },
                              searchFunction: context
                                  .read<PetsController>()
                                  .loadPetsSearched,
                            );
                          },
                        )
                      : StandardSliverAppbar(
                          title: Labels.pets,
                          canPop: false,
                          alternateAppbar: () {
                            context.read<PetsController>().clearPetsFiltered();
                            _isSearchBar.value = true;
                          },
                        ),
                ];
              },
              body: BlocConsumer<PetsController, PetsState>(
                listener: (context, state) {
                  state.status.matchAny(
                    any: () => _isLoading = false,
                    loading: () => _isLoading = true,
                    error: () {
                      _isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage ?? ''),
                        ),
                      );
                    },
                  );
                },
                buildWhen: (previous, current) => current.status.matchAny(
                  any: () => false,
                  initial: () => false,
                  loading: () => true,
                  refreshing: () => true,
                  loaded: () => true,
                  loadedSearched: () => true,
                  loadedFiltered: () => true,
                ),
                builder: (context, state) {
                  int lengthListPets = state.listPets.length;
                  int lengthListPetsSearched = state.listPetsSearched.length;
                  int lengthListPetsFiltered = state.listPetsFiltered.length;

                  if (_isLoading) {
                    Timer(
                      const Duration(milliseconds: 100),
                      () => _loadShimmerEffect.value = true,
                    );
                  }

                  return _isLoading
                      ? ValueListenableBuilder(
                          valueListenable: _loadShimmerEffect,
                          builder: (BuildContext context, bool canBeVisible,
                              Widget? child) {
                            return Visibility(
                              visible: canBeVisible,
                              child: GridView.builder(
                                padding: const EdgeInsets.all(12),
                                itemCount: 8,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 17,
                                  mainAxisExtent: 175,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                ),
                                itemBuilder: (context, index) {
                                  return const StandardShimmerEffect();
                                },
                              ),
                            );
                          })
                      : RefreshIndicator.adaptive(
                          onRefresh: () => context
                              .read<PetsController>()
                              .loadAllPets(refresh: true),
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: lengthListPetsFiltered != 0
                                ? lengthListPetsFiltered
                                : lengthListPetsSearched != 0
                                    ? lengthListPetsSearched
                                    : lengthListPets,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              mainAxisExtent:
                                  MediaQuery.textScaleFactorOf(context) > 1
                                      ? 198
                                      : 181,
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              return OpenContainer(
                                tappable: false,
                                closedColor: Colors.transparent,
                                closedElevation: 0,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                transitionType: ContainerTransitionType.fade,
                                openBuilder: (context, _) => PetDetailsRouter(
                                  pet: state.listPetsFiltered.isNotEmpty
                                      ? state.listPetsFiltered[index]
                                      : state.listPetsSearched.isNotEmpty
                                          ? state.listPetsSearched[index]
                                          : state.listPets[index],
                                ).page,
                                closedBuilder:
                                    (context, VoidCallback openContainer) =>
                                        PetCard(
                                  pet: state.listPetsFiltered.isNotEmpty
                                      ? state.listPetsFiltered[index]
                                      : state.listPetsSearched.isNotEmpty
                                          ? state.listPetsSearched[index]
                                          : state.listPets[index],
                                  onTap: openContainer,
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
            );
          },
        ),
        floatingActionButton: BlocBuilder<PetsController, PetsState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: ProjectColors.primary,
              onPressed: () async => context
                  .read<PetsController>()
                  .loadPetsFiltered(
                      await setPetFilter(true, FiltersState.petCurrentFilters)),
              child: Badge(
                isLabelVisible: state.currentFilters != null,
                backgroundColor: ProjectColors.primaryDark,
                label: const Text('!'),
                child: const Icon(
                  MaterialCommunityIcons.filter_variant,
                  color: ProjectColors.light,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
