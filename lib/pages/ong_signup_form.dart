import 'package:a_de_adote/pages/login_page.dart';
import 'package:a_de_adote/pages/ong_informations_form_page.dart';
import 'package:a_de_adote/widgets/login_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../style/project_colors.dart';
import '../style/project_fonts.dart';
import '../widgets/form_button.dart';
import '../widgets/standard_appbar.dart';

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

  void backToInformationsPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ONGInformationsFormPage(),
      ),
    );
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO Colocar um campo de "Confirmar senha" e fazê-lo funcionar.
    return Scaffold(
      backgroundColor: ProjectColors.secundary,
      appBar: StandardAppBar(
        title: 'Cadastro',
        route: backToInformationsPage,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: ProjectColors.secundary,
        ),
        child: Center(
          child: SingleChildScrollView(
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          LoginFormInput(
                            type: 'senha',
                            controller: _senha,
                            labelText: 'Senha',
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
