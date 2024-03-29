import 'package:a_de_adote/app/core/extensions/mask_formatters.dart';
import 'package:a_de_adote/app/pages/ong_register/cnpj_form/ong_cnpj_form_controller.dart';
import 'package:a_de_adote/app/pages/ong_register/cnpj_form/ong_cnpj_form_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';
import '../../../core/ui/widgets/form_button.dart';
import '../../../core/ui/widgets/standard_form_input.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/constants/buttons.dart';

class ONGCNPJFormPage extends StatefulWidget {
  const ONGCNPJFormPage({super.key});

  @override
  State<ONGCNPJFormPage> createState() => _ONGCNPJFormPageState();
}

class _ONGCNPJFormPageState extends State<ONGCNPJFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _cnpj = TextEditingController();
  var _isLoading = false;

  @override
  void dispose() {
    _cnpj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secondary,
      body: BlocConsumer<OngCnpjFormController, OngCnpjFormState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => _isLoading = false,
            loading: () => _isLoading = true,
            loaded: () {
              _isLoading = false;
              Navigator.of(context)
                  .pushNamed('/informacoes', arguments: state.ong);
            },
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
        builder: (context, state) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemNavigationBarColor: ProjectColors.secondary,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        bottom: MediaQuery.of(context).size.height * 0.2,
                      ),
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Labels.iniciar,
                                style: ProjectFonts.h3LightBold,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Labels.insiraCnpj,
                                style: ProjectFonts.h5Light,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              StandardFormInput(
                                controller: _cnpj,
                                labelText: Labels.cnpj,
                                mask: [
                                  context.maskFormatters.maskCNPJFormatter
                                ],
                                inputType: TextInputType.number,
                                validator: (value) {
                                  if ((value!.isEmpty) || (value.length < 18)) {
                                    return Labels.cnpjValido;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              FormButton(
                                formKey: _formKey,
                                text: Buttons.proximo,
                                action: () {
                                  final valid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                  if (valid) {
                                    context
                                        .read<OngCnpjFormController>()
                                        .loadOng(_cnpj.text);
                                  }
                                },
                                isLoading: _isLoading,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                  return Visibility(
                    visible: !isKeyboardVisible,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(
                            color: ProjectColors.lightDark,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                      text: Labels.possuiCadastro,
                                      style: ProjectFonts.smallLight),
                                  TextSpan(
                                    text: Labels.fazerLogin,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: ProjectColors.primaryLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final navigator = Navigator.of(context,
                                            rootNavigator: true);
                                        final sp = await SharedPreferences
                                            .getInstance();
                                        sp.setString('userType', 'ong');
                                        navigator.popAndPushNamed('/login');
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
