import 'dart:ui';
import 'package:a_de_adote/style/project_colors.dart';
import 'package:a_de_adote/widgets/form_button.dart';
import 'package:a_de_adote/widgets/form_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  bool isLoading = false;
  bool visibility = true;
  bool senhaFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secundary,
      body: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent.withOpacity(0.5),
                  Colors.transparent
                ],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              width: 500,
              height: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background/login_page_pets.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2,
                  sigmaY: 2,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              reverse: true,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: (MediaQuery.of(context).viewInsets.bottom > 0)
                        ? MediaQuery.of(context).size.height / 1.8
                        : MediaQuery.of(context).size.height / 1.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Image.asset(
                        'assets/images/logos/logo_completo_white.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FormInput(
                              type: 'login',
                              controller: email,
                              labelText: 'E-mail',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FormInput(
                              type: 'senha',
                              controller: senha,
                              labelText: 'Senha',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: TextButton(
                                    onPressed: (() => null),
                                    child: const Text(
                                      'Esqueci minha senha.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ProjectColors.light,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FormButton(
                              formKey: formKey,
                              text: 'ENTRAR',
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            TextButton(
                              onPressed: (() => null),
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Ainda não possui cadastro? ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ProjectColors.light,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Crie uma conta.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ProjectColors.primaryLight,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        ],
      ),
    );
  }
}
