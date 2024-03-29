//import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/pet_model.dart';
import '../../../services/auth_service.dart';

class PetCard extends StatelessWidget {
  final PetModel pet;
  final Function() onTap;

  const PetCard({
    super.key,
    required this.pet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                height: 100,
                width: double.infinity,
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/loaders/dog_run_loader_secondary.gif',
                      ),
                    ),
                  ),
                ),
                fadeInDuration: const Duration(milliseconds: 700),
                fadeOutDuration: const Duration(milliseconds: 300),
                imageUrl: pet.fotoUrl ??
                    'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_icon_white_1024.png?alt=media&token=8545f858-a26d-4a17-8b3c-3cdad23ae727',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          pet.nome ?? '#${pet.idMicrochip ?? 'NI'}',
                          style: ProjectFonts.h6SecundaryDarkBold
                              .copyWith(overflow: TextOverflow.ellipsis),
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
                          bool isLiked = (favoriteList ?? []).contains(pet.id)
                              ? true
                              : false;

                          return Visibility(
                            visible:
                                context.read<AuthService>().ongUser == null &&
                                    isLiked,
                            child: const Icon(
                              Icons.favorite,
                              size: 14,
                              color: ProjectColors.primaryLight,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      pet.ongNome ?? '-',
                      style: ProjectFonts.smallSecundaryDark.copyWith(
                        //color: const Color(0xFF646464),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            pet.especie,
                            style: ProjectFonts.smallSecundaryDark.copyWith(
                              color: const Color(0xFF646464),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        /*Flexible(
                          child: Row(
                            children: [
                              Icon(
                                pet.especie == Labels.cachorro
                                    ? MaterialCommunityIcons.dog
                                    : pet.especie == Labels.gato
                                        ? MaterialCommunityIcons.cat
                                        : pet.especie == Labels.passaro
                                            ? MaterialCommunityIcons.bird
                                            : pet.especie == Labels.outros
                                                ? MaterialCommunityIcons.paw
                                                : MaterialCommunityIcons.paw,
                                size: 14,
                                color: const Color(0xFF646464),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Flexible(
                                child: Text(
                                  pet.especie,
                                  style:
                                      ProjectFonts.smallSecundaryDark.copyWith(
                                    color: const Color(0xFF646464),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        Flexible(
                          child: Text(
                            pet.idadeAproximada,
                            style: ProjectFonts.smallSecundaryDark.copyWith(
                              color: const Color(0xFF646464),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    //* Opção mais "clean" a ser considerada
    /*Stack(
      children: [
        Card(
          semanticContainer: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      height: 100,
                      width: double.infinity,
                      placeholder: (context, url) => Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/loaders/dog_run_loader_secondary.gif',
                            ),
                          ),
                        ),
                      ),
                      fadeInDuration: const Duration(milliseconds: 700),
                      fadeOutDuration: const Duration(milliseconds: 300),
                      imageUrl: pet.fotoUrl ??
                          'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_icon_white_1024.png?alt=media&token=8545f858-a26d-4a17-8b3c-3cdad23ae727',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7.0, horizontal: 14),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    pet.nome ?? '#${pet.idMicrochip ?? 'NI'}',
                                    style: ProjectFonts.h6SecundaryDarkBold
                                        .copyWith(
                                            overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Text(
                              pet.idadeAproximada,
                              style: ProjectFonts.smallSecundaryDark.copyWith(
                                color: const Color(0xFF646464),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          pet.ongNome ?? '-',
                          style: ProjectFonts.smallSecundaryDark.copyWith(
                            color: const Color(0xFF646464),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, sp) {
                if (!sp.hasData) {
                  return const SizedBox.shrink();
                }

                List<String>? favoriteList = (sp.data as SharedPreferences)
                    .getStringList('favoriteList');
                bool isLiked =
                    (favoriteList ?? []).contains(pet.id) ? true : false;

                return Visibility(
                  visible:
                      context.read<AuthService>().ongUser == null && isLiked,
                  child: const CircleAvatar(
                    radius: 7,
                    backgroundColor: ProjectColors.light,
                    child: Icon(
                      Icons.favorite,
                      size: 9,
                      color: ProjectColors.primaryLight,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );*/
  }
}
