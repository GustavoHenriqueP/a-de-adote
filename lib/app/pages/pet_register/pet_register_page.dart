import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/extensions/dropdown_menu_items.dart';
import 'package:a_de_adote/app/core/ui/helpers/alert_dialog_alert.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/checkbox_row.dart';
import 'package:a_de_adote/app/core/ui/widgets/expanded_form_input.dart';
import 'package:a_de_adote/app/core/ui/widgets/form_button.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_appbar.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_dropdown.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_form_input.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:a_de_adote/app/pages/pet_register/pet_register_controller.dart';
import 'package:a_de_adote/app/pages/pet_register/pet_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import '../../core/ui/helpers/bottom_sheet_image_source.dart';

class PetRegisterPage extends StatefulWidget {
  const PetRegisterPage({super.key});

  @override
  State<PetRegisterPage> createState() => _PetRegisterPageState();
}

class _PetRegisterPageState extends State<PetRegisterPage>
    with BottomSheetImageSource, AlertDialogAlert {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final ValueNotifier<bool> _hasMicrochip = ValueNotifier(false);
  final _idMicrochip = TextEditingController();
  final ValueNotifier<String?> _especie = ValueNotifier('Cachorro');
  final ValueNotifier<String?> _porte = ValueNotifier('Pequeno');
  final ValueNotifier<String?> _unidadeIdade = ValueNotifier('meses');
  final ValueNotifier<String?> _sexo = ValueNotifier('Masculino');
  final _idadeAproximada = TextEditingController();
  final ValueNotifier<bool> _castrado = ValueNotifier(true);
  final ValueNotifier<bool> _vacina1 = ValueNotifier(false);
  final ValueNotifier<bool> _vacina2 = ValueNotifier(false);
  final ValueNotifier<bool> _vacina3 = ValueNotifier(false);
  final _sobre = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.jumpTo(120);
    });
  }

  @override
  void dispose() {
    _nome.dispose();
    _hasMicrochip.dispose();
    _idMicrochip.dispose();
    _especie.dispose();
    _porte.dispose();
    _unidadeIdade.dispose();
    _sexo.dispose();
    _idadeAproximada.dispose();
    _castrado.dispose();
    _vacina1.dispose();
    _vacina2.dispose();
    _vacina3.dispose();
    _sobre.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(title: Labels.titleCadastrarAnimal),
      body: BlocListener<PetRegisterController, PetRegisterState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => null,
            petCreated: () => Navigator.of(context).pop(),
            error: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
              ),
            ),
          );
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              systemNavigationBarColor: ProjectColors.secondary),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                reverse: true,
                physics: const ClampingScrollPhysics(),
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<PetRegisterController, PetRegisterState>(
                        builder: (context, state) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.24,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ProjectColors.lightDark,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: ProjectColors.primaryLight,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: state.status.matchAny(
                                  any: () => const AssetImage(
                                    'assets/images/support/add_a_photo_pet.png',
                                  ),
                                  loading: () => const AssetImage(
                                      'assets/images/loaders/filled_fading_balls.gif'),
                                  petCreated: () => const AssetImage(
                                      'assets/images/loaders/filled_fading_balls.gif'),
                                  imageLoaded: () => Image.file(
                                    state.image!,
                                  ).image,
                                ),
                                fit: state.status.matchAny(
                                  any: () => BoxFit.scaleDown,
                                  loading: () => BoxFit.scaleDown,
                                  imageLoaded: () => BoxFit.cover,
                                  petCreated: () => BoxFit.cover,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                    onTap: () async {
                                      final source = await setImageSorce();
                                      if (source != null) {
                                        // ignore: use_build_context_synchronously
                                        context
                                            .read<PetRegisterController>()
                                            .pickImage(source);
                                      }
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ProjectColors.secondaryDark
                                            .withOpacity(0.9),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(9),
                                          bottomRight: Radius.circular(9),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.photo_camera_outlined,
                                          color: ProjectColors.light,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            StandardFormInput(
                              controller: _nome,
                              labelText: Labels.nomeAnimal,
                              hintText: 'Opcional se digitar um № de Microchip',
                              maxLength: 30,
                              validator: (String? value) {
                                if ((value?.isEmpty ?? true) &&
                                    _idMicrochip.text.isEmpty) {
                                  return Labels.nomeAnimalValido;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: _hasMicrochip,
                              builder: (BuildContext context, bool value,
                                  Widget? child) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'CHIP',
                                          style: ProjectFonts.smallLight,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          color: ProjectColors.lightDark,
                                          child: Transform.scale(
                                            scale: 1.9,
                                            child: Checkbox(
                                              value: value,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              onChanged: (state) {
                                                _hasMicrochip.value = state!;
                                                _idMicrochip.text = '';
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: StandardFormInput(
                                        controller: _idMicrochip,
                                        labelText: '№ de Microchip',
                                        hintText: 'Opcional se digitar um nome',
                                        maxLength: 30,
                                        inputType: TextInputType.number,
                                        enabled: value,
                                        mask: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator: Validatorless.multiple(
                                          [
                                            Validatorless.number(
                                              Labels.nomeAnimalValido,
                                            ),
                                            (String? value) {
                                              if ((value?.isEmpty ?? true) &&
                                                  _nome.text.isEmpty) {
                                                return Labels.nomeAnimalValido;
                                              }
                                              return null;
                                            },
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: _especie,
                              builder: (BuildContext context, String? value,
                                  Widget? child) {
                                return StandardDropdown(
                                  labelText: Labels.especie,
                                  items: context.dropdownMenuItems.especies,
                                  value: value!,
                                  dropdownCallback: (selected) {
                                    _especie.value = selected;
                                  },
                                  validator: Validatorless.required(
                                    Labels.especieValida,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: _porte,
                                    builder: (BuildContext context,
                                        String? value, Widget? child) {
                                      return StandardDropdown(
                                        labelText: Labels.porte,
                                        items: context.dropdownMenuItems.porte,
                                        value: value!,
                                        dropdownCallback: (selected) {
                                          _porte.value = selected;
                                        },
                                        validator: Validatorless.required(
                                          Labels.porteValido,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: _sexo,
                                    builder: (BuildContext context,
                                        String? value, Widget? child) {
                                      return StandardDropdown(
                                        labelText: Labels.sexo,
                                        items: MediaQuery.textScaleFactorOf(
                                                    context) >
                                                1.15
                                            ? context
                                                .dropdownMenuItems.sexoAbreviado
                                            : context.dropdownMenuItems.sexo,
                                        value: value!,
                                        dropdownCallback: (selected) {
                                          _sexo.value = selected;
                                        },
                                        validator: Validatorless.required(
                                          Labels.valorInvalido,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: StandardFormInput(
                                    controller: _idadeAproximada,
                                    labelText: Labels.idadeAproximada,
                                    inputType: TextInputType.number,
                                    maxLength: 2,
                                    validator: Validatorless.required(
                                      Labels.idadeValida,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: _unidadeIdade,
                                    builder: (BuildContext context,
                                        String? value, Widget? child) {
                                      return StandardDropdown(
                                        labelText: '',
                                        items: context
                                            .dropdownMenuItems.unidadeIdade,
                                        value: value!,
                                        dropdownCallback: (selected) {
                                          _unidadeIdade.value = selected;
                                        },
                                        validator: Validatorless.required(
                                          Labels.valorInvalido,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: _castrado,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return CheckboxRow(
                                        labelText: Labels.castrado,
                                        value: value,
                                        checkboxCallback: (state) {
                                          _castrado.value = state!;
                                        },
                                      );
                                    },
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: _vacina1,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return CheckboxRow(
                                        labelText: Labels.antirrabica,
                                        value: value,
                                        checkboxCallback: (state) {
                                          _vacina1.value = state!;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: _vacina2,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return CheckboxRow(
                                        labelText: Labels.v3OuV8,
                                        value: value,
                                        gap: 0,
                                        checkboxCallback: (state) {
                                          _vacina2.value = state!;
                                        },
                                      );
                                    },
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: _vacina3,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return CheckboxRow(
                                        labelText: Labels.v5OuV10,
                                        value: value,
                                        checkboxCallback: (state) {
                                          _vacina3.value = state!;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ExpandedFormInput(
                              controller: _sobre,
                              labelText: Labels.sobre,
                              maxLength: 400,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            BlocBuilder<PetRegisterController,
                                PetRegisterState>(
                              builder: (context, state) {
                                return FormButton(
                                  formKey: _formKey,
                                  text: Buttons.cadastrar,
                                  action: () {
                                    final valid =
                                        (_formKey.currentState?.validate() ??
                                                false) &&
                                            state.image != null;
                                    if (state.image == null) {
                                      showAlert(Labels.insiraFoto, true);
                                    }
                                    if (valid) {
                                      String unidadeIdadeValue;
                                      if (_idadeAproximada.text == '1' ||
                                          _idadeAproximada.text == '01') {
                                        unidadeIdadeValue =
                                            _unidadeIdade.value == Labels.meses
                                                ? Labels.mes
                                                : Labels.ano;
                                      } else {
                                        unidadeIdadeValue =
                                            _unidadeIdade.value ?? '';
                                      }

                                      final PetModel pet = PetModel(
                                        nome: _nome.text,
                                        idMicrochip: _idMicrochip.text,
                                        idadeAproximada:
                                            '${_idadeAproximada.text} $unidadeIdadeValue',
                                        especie: _especie.value!,
                                        sexo: _sexo.value!,
                                        porte: _porte.value!,
                                        castrado: _castrado.value,
                                        vacinas: {
                                          'vacina1': _vacina1.value,
                                          'vacina2': _vacina2.value,
                                          'vacina3': _vacina3.value,
                                        },
                                        descricao: _sobre.text,
                                      );
                                      context
                                          .read<PetRegisterController>()
                                          .registerPet(pet, state.image);
                                    }
                                  },
                                  isLoading: state.status.matchAny(
                                    any: () => false,
                                    loading: () => true,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
