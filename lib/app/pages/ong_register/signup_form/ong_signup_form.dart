import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';
import '../../../core/ui/widgets/form_button.dart';
import '../../../models/ong_model.dart';
import '../../login/widgets/login_form_input.dart';

class ONGSignUpForm extends StatefulWidget {
  const ONGSignUpForm({super.key});

  @override
  State<ONGSignUpForm> createState() => _ONGSignUpFormState();
}

class _ONGSignUpFormState extends State<ONGSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmarSenha = TextEditingController();

  late OngModel ongModel;

  void salvar() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context, rootNavigator: true).popAndPushNamed('/login');
    }
  }

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
    _email.dispose();
    _senha.dispose();
    _confirmarSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secondary,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: ProjectColors.secondary,
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Último passo!',
                              style: ProjectFonts.h3LightBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Vamos agora criar seu usuário.',
                              style: ProjectFonts.h5Light,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          LoginFormInput(
                            type: 'login',
                            controller: _email,
                            labelText: 'E-mail',
                            fullSelectionText: true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          LoginFormInput(
                            type: 'signup_senha',
                            controller: _senha,
                            labelText: 'Senha',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          LoginFormInput(
                            type: 'signup_senha',
                            controller: _confirmarSenha,
                            labelText: 'Confirmar Senha',
                            validator: (value) {
                              if (value != _senha.text) {
                                return 'Senhas não conferem!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FormButton(
                            formKey: _formKey,
                            text: 'CADASTRAR',
                            action: salvar,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
