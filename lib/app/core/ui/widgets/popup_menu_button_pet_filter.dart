import 'dart:developer';

import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/widgets/dropdown_ong/dropdown_ong_router.dart';
import 'package:a_de_adote/app/core/ui/widgets/radio_row.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import '../styles/project_fonts.dart';
import 'checkbox_row.dart';

class PopupMenuButtonPetFilter extends StatefulWidget {
  const PopupMenuButtonPetFilter({super.key});

  @override
  State<PopupMenuButtonPetFilter> createState() =>
      _PopupMenuButtonPetFilterState();
}

class _PopupMenuButtonPetFilterState extends State<PopupMenuButtonPetFilter> {
  final ValueNotifier<String?> _ong = ValueNotifier('Todas');
  final ValueNotifier<bool> _dog = ValueNotifier(true);
  final ValueNotifier<bool> _cat = ValueNotifier(true);
  final ValueNotifier<bool> _bird = ValueNotifier(true);
  final ValueNotifier<bool> _other = ValueNotifier(true);
  int _idadeMaxima = 10;
  final ValueNotifier<int> _sexo = ValueNotifier(0);
  final ValueNotifier<bool> _mini = ValueNotifier(true);
  final ValueNotifier<bool> _pequeno = ValueNotifier(true);
  final ValueNotifier<bool> _medio = ValueNotifier(true);
  final ValueNotifier<bool> _grande = ValueNotifier(true);

  @override
  void dispose() {
    _ong.dispose();
    _dog.dispose();
    _cat.dispose();
    _bird.dispose();
    _other.dispose();
    _sexo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shadowColor: ProjectColors.lightDark,
      surfaceTintColor: ProjectColors.lightDark,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      position: PopupMenuPosition.under,
      icon: const Icon(
        MaterialCommunityIcons.filter_variant,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Container(
            padding: const EdgeInsets.all(6),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'ONG',
                          style: ProjectFonts.smallSecundaryDarkBold,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ValueListenableBuilder(
                            valueListenable: _ong,
                            builder: (BuildContext context, String? value,
                                Widget? child) {
                              return DropdownOngRouter(
                                value: value!,
                                dropdownCallback: (selected) {
                                  _ong.value = selected;
                                },
                              ).page;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Espécie',
                          style: ProjectFonts.smallSecundaryDarkBold,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 10,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _dog,
                            builder: (BuildContext context, bool isSelected,
                                Widget? child) {
                              return StandardChoiceChip(
                                label: 'Cachorro',
                                selected: isSelected,
                                choiceChipCallback: (state) {
                                  _dog.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _cat,
                            builder: (BuildContext context, bool isSelected,
                                Widget? child) {
                              return StandardChoiceChip(
                                label: 'Gato',
                                selected: isSelected,
                                choiceChipCallback: (state) {
                                  _cat.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _bird,
                            builder: (BuildContext context, bool isSelected,
                                Widget? child) {
                              return StandardChoiceChip(
                                label: 'Pássaro',
                                selected: isSelected,
                                choiceChipCallback: (state) {
                                  _bird.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _other,
                            builder: (BuildContext context, bool isSelected,
                                Widget? child) {
                              return StandardChoiceChip(
                                label: 'Outros',
                                selected: isSelected,
                                choiceChipCallback: (state) {
                                  _other.value = state!;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Idade máxima\n',
                            style: ProjectFonts.smallSecundaryDarkBold,
                          ),
                          TextSpan(
                            text: '(Deslize para alterar)',
                            style: ProjectFonts.smallSecundaryDark
                                .copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 45,
                          padding: const EdgeInsets.all(4),
                          child: StepperSwipe(
                            initialValue: 10,
                            speedTransitionLimitCount: 3,
                            onChanged: (int value) {
                              _idadeMaxima = value;
                            },
                            firstIncrementDuration: const Duration(
                              milliseconds: 250,
                            ),
                            secondIncrementDuration: const Duration(
                              milliseconds: 100,
                            ),
                            direction: Axis.horizontal,
                            dragButtonColor: ProjectColors.primary,
                            iconsColor: ProjectColors.secondaryDark,
                            withBackground: true,
                            withSpring: true,
                            withFastCount: true,
                            withPlusMinus: true,
                            maxValue: 20,
                            minValue: 1,
                            stepperValue: 1,
                          ),
                        ),
                        const Text(
                          'anos',
                          style: ProjectFonts.smallSecundaryDark,
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Sexo',
                          style: ProjectFonts.smallSecundaryDarkBold,
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: _sexo,
                      builder: (BuildContext context, int sexo, Widget? child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RadioRow(
                              labelText: 'Ambos',
                              labelStyle: ProjectFonts.smallSecundaryDark,
                              state: sexo,
                              value: 0,
                              radioCallback: (value) {
                                _sexo.value = value!;
                              },
                            ),
                            RadioRow(
                              labelText: 'Masculino',
                              labelStyle: ProjectFonts.smallSecundaryDark,
                              state: sexo,
                              value: 1,
                              radioCallback: (value) {
                                _sexo.value = value!;
                              },
                            ),
                            RadioRow(
                              labelText: 'Feminino',
                              labelStyle: ProjectFonts.smallSecundaryDark,
                              state: sexo,
                              value: 2,
                              radioCallback: (value) {
                                _sexo.value = value!;
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Porte',
                          style: ProjectFonts.smallSecundaryDarkBold,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _mini,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return CheckboxRow(
                                labelText: 'Mini',
                                labelStyle: ProjectFonts.smallSecundaryDark,
                                value: value,
                                checkboxCallback: (state) {
                                  _mini.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _pequeno,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return CheckboxRow(
                                labelText: 'Pequeno',
                                labelStyle: ProjectFonts.smallSecundaryDark,
                                value: value,
                                checkboxCallback: (state) {
                                  _pequeno.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _medio,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return CheckboxRow(
                                labelText: 'Médio',
                                labelStyle: ProjectFonts.smallSecundaryDark,
                                value: value,
                                checkboxCallback: (state) {
                                  _medio.value = state!;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _grande,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return CheckboxRow(
                                labelText: 'Grande',
                                labelStyle: ProjectFonts.smallSecundaryDark,
                                value: value,
                                checkboxCallback: (state) {
                                  _grande.value = state!;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProjectColors.light,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: ProjectColors.secondaryDark,
                            ),
                          ),
                        ),
                        child: const Text(
                          'LIMPAR FILTROS',
                          style: ProjectFonts.smallSecundaryDarkBold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProjectColors.primary,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'APLICAR',
                          style: ProjectFonts.smallLightBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
