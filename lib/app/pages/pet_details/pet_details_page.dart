import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/core/exceptions/launch_url_exception.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/pages/pet_details/pet_details_controller.dart';
import 'package:a_de_adote/app/pages/pet_details/pet_details_state.dart';
import 'package:a_de_adote/app/pages/pet_details/widgets/info_chip.dart';
import 'package:a_de_adote/app/pages/pet_details/widgets/info_container.dart';
import 'package:a_de_adote/app/pages/pet_edit/pet_edit_router.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository_impl.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:a_de_adote/app/services/whatsapp_launch_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/ui/helpers/alert_dialog_alert.dart';
import '../../core/ui/helpers/alert_dialog_confirmation_message.dart';
import '../../models/pet_model.dart';
import '../../repositories/database/cache_control.dart';

class PetDetailsPage extends StatefulWidget {
  final PetModel pet;
  final bool? isEditable;

  const PetDetailsPage({
    super.key,
    required this.pet,
    this.isEditable,
  });

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage>
    with AlertDialogConfirmationMessage, AlertDialogAlert {
  bool _edited = false;

  @override
  void initState() {
    super.initState();
    context.read<PetDetailsController>().loadPetState(widget.pet);
  }

  String getWhatsAppMessage(PetModel pet) {
    String petReference;
    if (pet.nome != null && pet.idMicrochip != null) {
      petReference = '${pet.nome} - № ID: ${pet.idMicrochip}';
    } else if (pet.nome != null && pet.idMicrochip == null) {
      petReference = '${pet.nome}';
    } else if (pet.nome == null && pet.idMicrochip != null) {
      petReference = '№ ID: ${pet.idMicrochip}';
    } else {
      petReference = 'NI';
    }

    final String message =
        'Olá! Vim pelo app A de Adote. Adorei o(a) _*$petReference*_ e gostaria de saber mais detalhes dele/dela.';

    return message;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isEditable ?? false) {
          Navigator.pop(context, _edited);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: BlocConsumer<PetDetailsController, PetDetailsState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => null,
              petDeleted: () => Navigator.pop(context, true),
              petEdited: () => _edited = true,
              error: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? ''),
                ),
              ),
            );
          },
          buildWhen: (previous, current) => current.status.matchAny(
            any: () => false,
            initial: () => false,
            petLoaded: () => true,
            petEdited: () => true,
            petDeleted: () => false,
          ),
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              placeholder: (context, url) => Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/loaders/filled_fading_balls.gif',
                                    ),
                                  ),
                                ),
                              ),
                              fadeInDuration: const Duration(milliseconds: 700),
                              fadeOutDuration:
                                  const Duration(milliseconds: 300),
                              imageUrl: state.pet!.fotoUrl ??
                                  'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_icon_white_1024.png?alt=media&token=8545f858-a26d-4a17-8b3c-3cdad23ae727',
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.infinity,
                              color: ProjectColors.secondaryDark,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                state.pet?.nome ??
                                                    '#${state.pet?.idMicrochip ?? 'NI'}',
                                                style: ProjectFonts.h5LightBold
                                                    .copyWith(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: state.pet?.idMicrochip !=
                                                      null &&
                                                  state.pet?.nome != null,
                                              child: Flexible(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 3,
                                                      backgroundColor:
                                                          ProjectColors
                                                              .primaryLight,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '#${state.pet?.idMicrochip ?? ''}',
                                                        style: ProjectFonts
                                                            .pLight
                                                            .copyWith(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              207, 207, 207),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Flexible(
                                          child: Text(
                                            state.pet!.ongNome ?? '-',
                                            style: ProjectFonts.pLight.copyWith(
                                              color: ProjectColors.lightDark,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: SharedPreferences.getInstance(),
                                    builder: (context, sp) {
                                      if (!sp.hasData) {
                                        return const SizedBox.shrink();
                                      }
                                      List<String>? favoriteList =
                                          (sp.data as SharedPreferences)
                                              .getStringList('favoriteList');
                                      bool isLiked = (favoriteList ?? [])
                                              .contains(state.pet?.id)
                                          ? true
                                          : false;

                                      return Visibility(
                                        visible: context
                                                .read<AuthService>()
                                                .ongUser ==
                                            null, // Significa que não é uma Ong acessando os detalhes do Pet.
                                        child: LikeButton(
                                          size: 48,
                                          circleColor: const CircleColor(
                                            start: ProjectColors.primaryLight,
                                            end: ProjectColors.primaryLight,
                                          ),
                                          bubblesColor: const BubblesColor(
                                            dotPrimaryColor:
                                                ProjectColors.primaryLight,
                                            dotSecondaryColor:
                                                ProjectColors.primaryLight,
                                          ),
                                          isLiked: isLiked,
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_outline,
                                              color: isLiked
                                                  ? ProjectColors.primaryLight
                                                  : ProjectColors.light,
                                              size: 26,
                                            );
                                          },
                                          onTap: (bool isLiked) async {
                                            if (isLiked) {
                                              context
                                                  .read<PetDetailsController>()
                                                  .removeFromFavorites(
                                                      state.pet!.id!);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      Labels.removidoFavoritos),
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                              return false;
                                            } else {
                                              context
                                                  .read<PetDetailsController>()
                                                  .addToFavorites(
                                                      state.pet!.id!);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(Labels
                                                      .adicionadoFavoritos),
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                              return true;
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InfoContainer(
                                      title: Labels.especie,
                                      info: state.pet!.especie,
                                      icon: MaterialCommunityIcons.paw_outline,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: InfoContainer(
                                      title: Labels.porte,
                                      info: state.pet!.porte,
                                      icon: MaterialCommunityIcons.tape_measure,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InfoContainer(
                                      title: Labels.idadeAprox,
                                      info: state.pet!.idadeAproximada,
                                      icon: Icons.info_outline,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: InfoContainer(
                                      title: Labels.sexo,
                                      info: state.pet!.sexo,
                                      icon: MaterialCommunityIcons
                                          .gender_male_female,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Divider(),
                            ),
                            Visibility(
                              visible: widget.pet.especie == Labels.cachorro ||
                                  widget.pet.especie == Labels.gato,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 12,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: [
                                          InfoChip(
                                              info: Labels.castrado,
                                              infoState: state.pet!.castrado),
                                          InfoChip(
                                              info: Labels.antirrabica,
                                              infoState: state
                                                  .pet!.vacinas!['vacina1']),
                                          InfoChip(
                                              info: widget.pet.especie ==
                                                      Labels.cachorro
                                                  ? Labels.v8
                                                  : Labels.v3,
                                              infoState: state
                                                  .pet!.vacinas!['vacina2']),
                                          InfoChip(
                                              info: widget.pet.especie ==
                                                      Labels.cachorro
                                                  ? Labels.v10
                                                  : Labels.v5,
                                              infoState: state
                                                  .pet!.vacinas!['vacina3']),
                                          InfoChip(
                                              info: 'Microchip',
                                              infoState:
                                                  state.pet!.idMicrochip !=
                                                      null),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Divider(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 16,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    Labels.sobre,
                                    style: ProjectFonts.pLightBold,
                                  ),
                                  Text(
                                    state.pet!.descricao ?? Labels.semDescricao,
                                    style: ProjectFonts.smallLight,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !((widget.isEditable ?? false) &&
                          context.read<AuthService>().ongUser?.uid ==
                              widget.pet.ongId),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ProjectColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10)),
                          onPressed: () async {
                            try {
                              if (state.pet!.ongId != null) {
                                try {
                                  await showAlert(
                                      'Ficamos muito felizes que você se interessou por esse animalzinho! Apenas um rápido aviso:\n\nO processo de adoção pode ser diferente para cada Instituição, e é responsabilidade dela cuidar de todos os procedimentos necessários.',
                                      true);
                                  OngRepository ongRepository =
                                      OngRepositoryImpl(
                                    // ignore: use_build_context_synchronously
                                    dio: context.read(),
                                    // ignore: use_build_context_synchronously
                                    auth: context.read(),
                                    // ignore: use_build_context_synchronously
                                    cacheControl: context.read<CacheControl>(),
                                  );
                                  final ong = await ongRepository
                                      .getOngById(state.pet!.ongId!);
                                  await WhatsappLaunchService.openWhatsApp(
                                      ong.whatsapp!
                                          .replaceAll(RegExp(r'[^0-9]'), ''),
                                      getWhatsAppMessage(state.pet!));
                                } on FirestoreException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.message),
                                    ),
                                  );
                                }
                              }
                            } on LaunchUrlException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.message),
                                ),
                              );
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Buttons.falarComOng,
                                style: ProjectFonts.pLightBold,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Icon(
                                  MaterialCommunityIcons.whatsapp,
                                  size: 24,
                                  color: ProjectColors.light,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: InkWell(
                      onTap: () {
                        if (widget.isEditable ?? false) {
                          Navigator.pop(context, _edited);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ProjectColors.primaryLight.withOpacity(0.2),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: ProjectColors.light,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: (widget.isEditable ?? false) &&
                      context.read<AuthService>().ongUser?.uid ==
                          widget.pet.ongId,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.04,
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: PopupMenuButton(
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ProjectColors.primaryLight.withOpacity(0.2),
                          ),
                          child: const Icon(
                            Icons.more_vert,
                            size: 24,
                            color: ProjectColors.light,
                          ),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(
                                Icons.edit,
                                size: 22,
                                color: Colors.blue,
                              ),
                              title: const Text(
                                Buttons.editar,
                                style: ProjectFonts.pSecundaryDark,
                              ),
                              onTap: () async {
                                Navigator.of(context).pop();
                                PetModel? petUpdated = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PetEditRouter.page,
                                    settings:
                                        RouteSettings(arguments: state.pet),
                                  ),
                                );
                                if (petUpdated != null) {
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<PetDetailsController>()
                                      .petEdited(petUpdated);
                                }
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(
                                Icons.cancel_outlined,
                                size: 22,
                                color: ProjectColors.danger,
                              ),
                              title: const Text(
                                Buttons.excluir,
                                style: ProjectFonts.pSecundaryDark,
                              ),
                              onTap: () async {
                                Navigator.of(context).pop();
                                bool? action = await confirmAction(
                                    Labels.confirmacaoExcluirAnimal);
                                if (action == null || action == false) {
                                  null;
                                } else {
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<PetDetailsController>()
                                      .deletePet(state.pet!);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
