import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/extensions/mask_formatters.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_form_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';
import '../../../core/ui/widgets/form_button.dart';
import '../../../models/ong_model.dart';
import '../../login/widgets/login_form_input.dart';
import 'ong_signup_form_controller.dart';
import 'ong_signup_form_state.dart';

class ONGSignUpFormPage extends StatefulWidget {
  const ONGSignUpFormPage({super.key});

  @override
  State<ONGSignUpFormPage> createState() => _ONGSignUpFormPageState();
}

class _ONGSignUpFormPageState extends State<ONGSignUpFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _whatsapp = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmarSenha = TextEditingController();
  final ValueNotifier<bool> _isChecked = ValueNotifier(false);
  bool _isLoading = false;

  late OngModel ongModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ongModel = ModalRoute.of(context)?.settings.arguments as OngModel;
      _email.text = ongModel.email;
    });
  }

  @override
  void dispose() {
    _whatsapp.dispose();
    _email.dispose();
    _senha.dispose();
    _confirmarSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secondary,
      body: BlocConsumer<OngSignupFormController, OngSignupFormState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => _isLoading = false,
            loading: () => _isLoading = true,
            userCreated: () {
              _isLoading = false;
              Navigator.of(context, rootNavigator: true)
                  .popAndPushNamed('/main');
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
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 1.5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Labels.ultimoPasso,
                                  style: ProjectFonts.h3LightBold,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Labels.criarUsuario,
                                  style: ProjectFonts.h5Light,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              child: StandardFormInput(
                                controller: _whatsapp,
                                labelText: Labels.whatsApp,
                                mask: [context.maskFormatters.maskTelFormatter],
                                inputType: TextInputType.phone,
                                trailing: const Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  preferBelow: false,
                                  message: Labels.whatsAppExplain,
                                  child: Icon(
                                    Icons.info_outline,
                                    color: ProjectColors.lightDark,
                                  ),
                                ),
                                validator: Validatorless.required(
                                    Labels.whatsAppValido),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              child: LoginFormInput(
                                type: 'login',
                                controller: _email,
                                labelText: Labels.email,
                                maxLength: 256,
                                fullSelectionText: true,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              child: LoginFormInput(
                                type: 'signup_senha',
                                controller: _senha,
                                labelText: Labels.senha,
                                maxLength: 50,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              child: LoginFormInput(
                                type: 'signup_senha',
                                controller: _confirmarSenha,
                                labelText: Labels.confirmarSenha,
                                maxLength: 50,
                                validator: (value) {
                                  if (value != _senha.text) {
                                    return Labels.confirmarSenhaValida;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 33, right: 45),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: _isChecked,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return Checkbox(
                                        value: value,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (value) =>
                                            _isChecked.value = value ?? false,
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Confirmo que li e aceito os ',
                                        style: const TextStyle(
                                            color: ProjectColors.light),
                                        children: [
                                          TextSpan(
                                            text: 'Termos de Uso e Condições',
                                            style: const TextStyle(
                                              color: ProjectColors.primaryLight,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => Navigator.of(
                                                      context,
                                                      rootNavigator: true)
                                                  .pushNamed('/pdf_view',
                                                      arguments: 'termos'),
                                          ),
                                          const TextSpan(text: ' e '),
                                          TextSpan(
                                            text: 'Política de privacidade',
                                            style: const TextStyle(
                                              color: ProjectColors.primaryLight,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => Navigator.of(
                                                      context,
                                                      rootNavigator: true)
                                                  .pushNamed('/pdf_view',
                                                      arguments: 'politica'),
                                          ),
                                          const TextSpan(text: '.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              child: ValueListenableBuilder(
                                  valueListenable: _isChecked,
                                  builder: (BuildContext context,
                                      bool isChecked, Widget? child) {
                                    return FormButton(
                                      formKey: _formKey,
                                      text: Buttons.cadastrar,
                                      disabled: !isChecked,
                                      action: !isChecked
                                          ? () => ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Confirme os Termos de Uso e Política de Privacidade para prosseguir!'),
                                                ),
                                              )
                                          : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final ong = ongModel.copyWith(
                                                    email: _email.text,
                                                    whatsapp: _whatsapp.text);
                                                context
                                                    .read<
                                                        OngSignupFormController>()
                                                    .signUpOng(
                                                        ong, _senha.text);
                                              }
                                            },
                                      isLoading: _isLoading,
                                    );
                                  },),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
