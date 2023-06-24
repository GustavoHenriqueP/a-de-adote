import 'dart:async';
import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/extensions/capitalize_only_first_letter_extension.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_drawer.dart';
import 'package:a_de_adote/app/pages/ong_profile/ong_space/widgets/custom_expansion_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../core/ui/helpers/filters_state.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../models/ong_model.dart';
import '../home/tabs_state.dart';

class OngDetailsPage extends StatelessWidget {
  final OngModel ong;

  const OngDetailsPage({super.key, required this.ong});

  @override
  Widget build(BuildContext context) {
    String enderecoConcat;
    if (ong.logradouro != null && ong.logradouro != '') {
      enderecoConcat =
          '${ong.logradouro?.stringAdjusted}, ${ong.numero} - ${ong.bairro?.stringAdjusted} / ${ong.municipio.stringAdjusted} - ${ong.uf} / ${ong.cep}';
    } else {
      enderecoConcat = '${ong.municipio.stringAdjusted} - ${ong.uf}';
    }

    return Scaffold(
      drawer: const StandardDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.27,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: ProjectColors.lightDark,
                        ),
                        child: CachedNetworkImage(
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
                          fadeOutDuration: const Duration(milliseconds: 300),
                          imageUrl: ong.fotoUrl ??
                              'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_completo_withblue.png?alt=media&token=6303a763-dc1d-4095-82be-653cfca32df2',
                          height: 60,
                          width: 110,
                          fit: BoxFit.fitWidth,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: ProjectColors.danger,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.048,
                        width: double.infinity,
                        color: ProjectColors.primaryDark,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                ong.fantasia,
                                style: ProjectFonts.h6LightBold,
                                overflow: TextOverflow.ellipsis,
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
                                              text: ong.cnpj,
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
                                              text: ong.email,
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
                                              text: ong.telefone ?? ' -',
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
                                              text: ong.whatsapp ?? ' -',
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
                                isOng: false,
                                title: Labels.doacaoPix,
                                isInitialExpanded: true,
                                bodyPadding: EdgeInsets.symmetric(
                                  vertical: ong.pix == null ? 10 : 0,
                                  horizontal: 10,
                                ),
                                body: ong.pix == null
                                    ? Text(
                                        Labels.pixVazio,
                                        style: ProjectFonts.pLight.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            ong.pix?.keys.first == Labels.cnpj
                                                ? Icons.info_outline_rounded
                                                : ong.pix?.keys.first ==
                                                        Labels.celular
                                                    ? MaterialCommunityIcons
                                                        .whatsapp
                                                    : ong.pix?.keys.first ==
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
                                                        '${ong.pix?.keys.first}: ',
                                                    style:
                                                        ProjectFonts.pLightBold,
                                                  ),
                                                  TextSpan(
                                                    text: ong.pix?.values.first,
                                                    style: ProjectFonts.pLight,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => Clipboard.setData(
                                              ClipboardData(
                                                text: ong.pix?.values.first
                                                    as String,
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
                                              color: ProjectColors.primaryLight,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomExpansionTile(
                                isOng: false,
                                title: Labels.sobre,
                                isInitialExpanded: true,
                                body: ong.informacoes == null
                                    ? Text(
                                        Labels.informacoesOngVazia,
                                        style: ProjectFonts.smallLight.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      )
                                    : Text(
                                        ong.informacoes!,
                                        style: ProjectFonts.smallLight,
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
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
                      padding: const EdgeInsets.symmetric(vertical: 10)),
                  onPressed: () {
                    final filter = {
                      'ong': ong.id,
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

                    Navigator.of(context).pop();
                    Timer(
                      const Duration(milliseconds: 500),
                      () {
                        FiltersState.setPetCurrentFilters(filter);
                        context.read<TabsState>().setTabIndex(0);
                      },
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Buttons.verAnimais,
                        style: ProjectFonts.pLightBold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 3),
                        child: Icon(
                          MaterialCommunityIcons.paw,
                          size: 24,
                          color: ProjectColors.light,
                        ),
                      ),
                    ],
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
                onTap: () => Navigator.of(context).pop(),
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
        ],
      ),
    );
  }
}
