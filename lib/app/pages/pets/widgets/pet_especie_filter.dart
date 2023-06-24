// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';

import '../../../core/constants/labels.dart';
import '../../../core/ui/widgets/standard_choice_chip.dart';

class PetEspecieFilter extends StatelessWidget {
  final ValueNotifier<bool> dogFilterState;
  final ValueNotifier<bool> catFilterState;
  final ValueNotifier<bool> birdFilterState;
  final ValueNotifier<bool> othersFilterState;

  final void Function(bool?)? dogCallback;
  final void Function(bool?)? catCallback;
  final void Function(bool?)? birdCallback;
  final void Function(bool?)? othersCallback;

  const PetEspecieFilter({
    super.key,
    required this.dogFilterState,
    required this.catFilterState,
    required this.birdFilterState,
    required this.othersFilterState,
    required this.dogCallback,
    required this.catCallback,
    required this.birdCallback,
    required this.othersCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: dogFilterState,
                builder:
                    (BuildContext context, bool isSelected, Widget? child) {
                  return Transform.scale(
                    scale: 1.05,
                    child: StandardChoiceChip(
                      avatar: const Icon(
                        MaterialCommunityIcons.dog,
                        size: 15,
                      ),
                      label: Labels.cachorro,
                      selected: isSelected,
                      selectedColor: ProjectColors.primary.withOpacity(0.7),
                      choiceChipCallback: dogCallback,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 12,
              ),
              ValueListenableBuilder(
                valueListenable: catFilterState,
                builder:
                    (BuildContext context, bool isSelected, Widget? child) {
                  return Transform.scale(
                    scale: 1.05,
                    child: StandardChoiceChip(
                      avatar: const Icon(
                        MaterialCommunityIcons.cat,
                        size: 15,
                      ),
                      label: Labels.gato,
                      selected: isSelected,
                      selectedColor: ProjectColors.primary.withOpacity(0.7),
                      choiceChipCallback: catCallback,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 12,
              ),
              ValueListenableBuilder(
                valueListenable: birdFilterState,
                builder:
                    (BuildContext context, bool isSelected, Widget? child) {
                  return Transform.scale(
                    scale: 1.05,
                    child: StandardChoiceChip(
                      avatar: const Icon(
                        MaterialCommunityIcons.bird,
                        size: 15,
                      ),
                      label: Labels.passaro,
                      selected: isSelected,
                      selectedColor: ProjectColors.primary.withOpacity(0.7),
                      choiceChipCallback: birdCallback,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 12,
              ),
              ValueListenableBuilder(
                valueListenable: othersFilterState,
                builder:
                    (BuildContext context, bool isSelected, Widget? child) {
                  return Transform.scale(
                    scale: 1.05,
                    child: StandardChoiceChip(
                      avatar: const Icon(
                        MaterialCommunityIcons.paw,
                        size: 15,
                      ),
                      label: Labels.outros,
                      selected: isSelected,
                      selectedColor: ProjectColors.primary.withOpacity(0.7),
                      choiceChipCallback: othersCallback,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
