import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/extensions/capitalize_only_first_letter_extension.dart';
import 'package:a_de_adote/app/core/ui/helpers/bottom_sheet_image_source.dart';
import 'package:a_de_adote/app/core/ui/helpers/update_dialog_ong_description.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_shimmer_effect.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_space/ong_space_state.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_space/widgets/custom_expansion_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../core/ui/helpers/update_dialog_ong_pix.dart';
import '../../../core/ui/helpers/update_dialog_ong_data.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../models/ong_model.dart';
import 'ong_space_controller.dart';

class OngSpacePage extends StatefulWidget {
  const OngSpacePage({super.key});

  @override
  State<OngSpacePage> createState() => _OngSpacePageState();
}

class _OngSpacePageState extends State<OngSpacePage>
    with
        BottomSheetImageSource,
        UpdateDialogOngData,
        UpdateDialogOngDescription,
        UpdateDialogOngPix {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OngSpaceController>().loadOng();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: const StandardDrawer(),
        body: BlocConsumer<OngSpaceController, OngSpaceState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => _isLoading = false,
              loading: () => _isLoading = true,
              fieldUpdated: () => context.read<OngSpaceController>().loadOng(),
              error: () {
                _isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMesssage ?? ''),
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
            String enderecoConcat;
            if (state.ong?.logradouro != null && state.ong?.logradouro != '') {
              enderecoConcat =
                  '${state.ong?.logradouro?.stringAdjusted}, ${state.ong?.numero} - ${state.ong?.bairro?.stringAdjusted} / ${state.ong?.municipio.stringAdjusted} - ${state.ong?.uf} / ${state.ong?.cep}';
            } else {
              enderecoConcat =
                  '${state.ong?.municipio.stringAdjusted} - ${state.ong?.uf}';
            }

            return _isLoading
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.24,
                          width: double.infinity,
                          child: const StandardShimmerEffect(radiusValue: 0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.048,
                          width: double.infinity,
                          child: const StandardShimmerEffect(radiusValue: 0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 19,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: const StandardShimmerEffect(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 19,
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: const StandardShimmerEffect(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 19,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: const StandardShimmerEffect(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 19,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: const StandardShimmerEffect(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: const StandardShimmerEffect(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.048,
                          width: double.infinity,
                          child: const StandardShimmerEffect(radiusValue: 0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.048,
                          width: double.infinity,
                          child: const StandardShimmerEffect(radiusValue: 0),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final source = await setImageSorce();
                            if (source != null) {
                              // ignore: use_build_context_synchronously
                              context
                                  .read<OngSpaceController>()
                                  .pickAndSaveImage(source);
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.24,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: ProjectColors.lightDark,
                            ),
                            child: state.ong?.fotoUrl != null
                                ? CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/loaders/filled_fading_balls.gif',
                                          ),
                                        ),
                                      ),
                                    ),
                                    fadeInDuration:
                                        const Duration(milliseconds: 700),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 300),
                                    imageUrl: state.ong?.fotoUrl ??
                                        'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_icon_white_1024.png?alt=media&token=8545f858-a26d-4a17-8b3c-3cdad23ae727',
                                    height: 60,
                                    width: 110,
                                    fit: BoxFit.fitWidth,
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: ProjectColors.danger,
                                    ),
                                  )
                                : const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.photo_camera_outlined,
                                        size: 36,
                                        color: ProjectColors.secondaryDark,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        Labels.adicioneFoto,
                                        style: ProjectFonts.h6SecundaryDark,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        Container(
                          height: 37.5,
                          width: double.infinity,
                          color: ProjectColors.primaryDark,
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  state.ong?.fantasia ?? '',
                                  style: ProjectFonts.h6LightBold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final String ongNameFantasia =
                                      state.ong!.fantasia;
                                  OngModel? currentOng =
                                      await showChangeOngData(state.ong!);
                                  if (currentOng != null) {
                                    bool isNameChanged = false;
                                    if (currentOng.fantasia !=
                                        ongNameFantasia) {
                                      isNameChanged = true;
                                    }
                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<OngSpaceController>()
                                        .updateOngData(
                                            currentOng, isNameChanged);
                                  }
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: ProjectColors.light,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.info_outline_rounded,
                                        color: ProjectColors.light,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: Labels.cnpjField,
                                                style: ProjectFonts.pLightBold,
                                              ),
                                              TextSpan(
                                                text: state.ong?.cnpj,
                                                style: ProjectFonts.pLight,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.email_outlined,
                                        color: ProjectColors.light,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: Labels.emailField,
                                                style: ProjectFonts.pLightBold,
                                              ),
                                              TextSpan(
                                                text: state.ong?.email,
                                                style: ProjectFonts.pLight,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone_outlined,
                                        color: ProjectColors.light,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: Labels.telField,
                                                style: ProjectFonts.pLightBold,
                                              ),
                                              TextSpan(
                                                text:
                                                    state.ong?.telefone ?? ' -',
                                                style: ProjectFonts.pLight,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        MaterialCommunityIcons.whatsapp,
                                        color: ProjectColors.light,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: Labels.whatsAppField,
                                                style: ProjectFonts.pLightBold,
                                              ),
                                              TextSpan(
                                                text:
                                                    state.ong?.whatsapp ?? ' -',
                                                style: ProjectFonts.pLight,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.home_outlined,
                                        color: ProjectColors.light,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: Labels.enderecoField,
                                                style: ProjectFonts.pLightBold,
                                              ),
                                              TextSpan(
                                                text: enderecoConcat,
                                                style: ProjectFonts.pLight,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                CustomExpansionTile(
                                  isOng: true,
                                  title: Labels.doacaoPix,
                                  edit: () async {
                                    Map<String, dynamic>? newPix =
                                        await showChangeOngPix(state.ong?.pix);
                                    if (newPix != null) {
                                      // ignore: use_build_context_synchronously
                                      context
                                          .read<OngSpaceController>()
                                          .updateOngPix(newPix);
                                    }
                                  },
                                  bodyPadding: EdgeInsets.symmetric(
                                    vertical: state.ong?.pix == null ? 10 : 0,
                                    horizontal: 10,
                                  ),
                                  body: state.ong?.pix == null
                                      ? Text(
                                          Labels.pixVazioAdicione,
                                          style: ProjectFonts.pLight.copyWith(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              state.ong?.pix?.keys.first ==
                                                      Labels.cnpj
                                                  ? Icons.info_outline_rounded
                                                  : state.ong?.pix?.keys
                                                              .first ==
                                                          Labels.celular
                                                      ? MaterialCommunityIcons
                                                          .whatsapp
                                                      : state.ong?.pix?.keys
                                                                  .first ==
                                                              Labels.email
                                                          ? Icons.email_outlined
                                                          : null,
                                              color: ProjectColors.light,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${state.ong?.pix?.keys.first}: ',
                                                      style: ProjectFonts
                                                          .pLightBold,
                                                    ),
                                                    TextSpan(
                                                      text: state.ong?.pix
                                                          ?.values.first,
                                                      style:
                                                          ProjectFonts.pLight,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () =>
                                                  Clipboard.setData(
                                                ClipboardData(
                                                  text: state.ong?.pix?.values
                                                      .first as String,
                                                ),
                                              ).then(
                                                (_) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        Labels.pixCopiado,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              icon: const Icon(
                                                Icons.copy,
                                                size: 16,
                                                color:
                                                    ProjectColors.primaryLight,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomExpansionTile(
                                  isOng: true,
                                  title: Labels.sobre,
                                  edit: () async {
                                    String? description =
                                        await showChangeDescription(
                                            state.ong?.informacoes);
                                    if (description != null) {
                                      // ignore: use_build_context_synchronously
                                      context
                                          .read<OngSpaceController>()
                                          .updateDescriptionOng(description);
                                    }
                                  },
                                  body: state.ong?.informacoes == null
                                      ? Text(
                                          Labels.informacoesOngVaziaAdicione,
                                          style:
                                              ProjectFonts.smallLight.copyWith(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        )
                                      : Text(
                                          state.ong!.informacoes!,
                                          style: ProjectFonts.smallLight,
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
