import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class OngAnimalCard extends StatelessWidget {
  final PetModel pet;
  final Function() onTap;
  final Function() editMethod;
  final Function() deleteMethod;

  const OngAnimalCard({
    super.key,
    required this.pet,
    required this.onTap,
    required this.editMethod,
    required this.deleteMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  pet.fotoUrl == null
                      ? const SizedBox(
                          height: 60,
                          width: 110,
                        )
                      : ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
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
                            imageUrl: pet.fotoUrl ??
                                'https://firebasestorage.googleapis.com/v0/b/a-de-adote.appspot.com/o/logos%2Flogo_icon_white_1024.png?alt=media&token=8545f858-a26d-4a17-8b3c-3cdad23ae727',
                            height: 70,
                            width: 110,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: ProjectColors.danger,
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                pet.nome ?? '#${pet.idMicrochip ?? 'NI'}',
                                style:
                                    ProjectFonts.h6SecundaryDarkBold.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
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
                              width: 2,
                            ),
                            Flexible(
                              child: Text(
                                pet.especie,
                                style: ProjectFonts.smallSecundaryDark.copyWith(
                                  color: const Color(0xFF646464),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: editMethod,
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.edit,
                            size: 22,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: deleteMethod,
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.cancel_outlined,
                            size: 22,
                            color: ProjectColors.danger,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
