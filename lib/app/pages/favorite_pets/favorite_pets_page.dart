import 'dart:async';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/pages/favorite_pets/favorite_pets_controller.dart';
import 'package:a_de_adote/app/pages/favorite_pets/favorite_pets_state.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../core/ui/styles/project_fonts.dart';
import '../../core/ui/widgets/standard_drawer.dart';
import '../../core/ui/widgets/standard_shimmer_effect.dart';
import '../../core/ui/widgets/standard_sliver_appbar.dart';
import '../pet_details/pet_details_router.dart';
import '../pets/widgets/pet_card.dart';

class FavoritePetsPage extends StatefulWidget {
  const FavoritePetsPage({super.key});

  @override
  State<FavoritePetsPage> createState() => _FavoritePetsPageState();
}

class _FavoritePetsPageState extends State<FavoritePetsPage> {
  bool _isLoading = true;
  final ValueNotifier<bool> _loadMessage = ValueNotifier(false);
  final ValueNotifier<bool> _loadShimmerEffect = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FavoritePetsController>().loadFavoritePets(true);
    });
  }

  @override
  void dispose() {
    _loadMessage.dispose();
    _loadShimmerEffect.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: const StandardDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
            return [
              const StandardSliverAppbar(
                title: Labels.titleFavoritos,
                canPop: false,
              ),
            ];
          },
          body: BlocConsumer<FavoritePetsController, FavoritePetsState>(
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
              loaded: () => true,
            ),
            builder: (context, state) {
              int lengthFavoriteList = state.listFavoritePets.length;

              if (lengthFavoriteList == 0) {
                Timer(
                  const Duration(milliseconds: 100),
                  () => _loadMessage.value = true,
                );
              }

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
                  : lengthFavoriteList == 0
                      ? ValueListenableBuilder(
                          valueListenable: _loadMessage,
                          builder: (BuildContext context, bool canBeVisible,
                              Widget? child) {
                            return Visibility(
                              visible: canBeVisible,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    MaterialCommunityIcons.paw,
                                    size: 18,
                                    color: ProjectColors.light,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          Labels.naoPossuiFavoritos,
                                          style: ProjectFonts.pLight,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          })
                      : GridView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: lengthFavoriteList,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            mainAxisExtent:
                                MediaQuery.textScaleFactorOf(context) > 1
                                    ? 198
                                    : 181,

                            //*Opção mais clean a ser considerada
                            /*mainAxisExtent:
                                  MediaQuery.textScaleFactorOf(context) > 1
                                      ? 180
                                      : 163,*/
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
                                pet: state.listFavoritePets[index],
                              ).page,
                              onClosed: (petWasRemoved) {
                                context
                                    .read<FavoritePetsController>()
                                    .loadFavoritePets(false);
                              },
                              closedBuilder:
                                  (context, VoidCallback openContainer) =>
                                      PetCard(
                                pet: state.listFavoritePets[index],
                                onTap: openContainer,
                              ),
                            );
                          },
                        );
            },
          ),
        ),
      ),
    );
  }
}
