import 'dart:ui';
import 'package:a_de_adote/style/project_colors.dart';
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
                      'lib/assets/images/background/login_page_pets.png'),
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
                  maxHeight: MediaQuery.of(context).size.height / 1.4
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Image.asset(
                        'lib/assets/images/logos/logo_completo_white.png',
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
                              TextFormField(
                                controller: email,
                                style: const TextStyle(
                                    color: ProjectColors.light, fontSize: 16),
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: const EdgeInsets.only(left: 14, top: 16, bottom: 16),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        ProjectColors.light.withOpacity(0.2),
                                    labelText: 'E-mail',
                                    labelStyle: const TextStyle(
                                        color: ProjectColors.light,
                                        fontSize: 16)),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe o e-mail';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              TextFormField(
                                controller: senha,
                                style: const TextStyle(
                                    color: ProjectColors.light, fontSize: 16),
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: const EdgeInsets.only(left: 14, top: 16, bottom: 16),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        ProjectColors.light.withOpacity(0.2),
                                    labelText: 'Senha',
                                    labelStyle: const TextStyle(
                                        color: ProjectColors.light,
                                        fontSize: 16)),
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe a senha!';
                                  } else if (value.length < 6) {
                                    return 'Senha com menos de 6 caracteres';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: const BoxDecoration(
                                  color: ProjectColors.primary,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  hoverColor: ProjectColors.primaryDark,
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      isLoading = true;
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'ENTRAR',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ProjectColors.light),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextButton(
                                onPressed: (() => null),
                                child: RichText(
                                  text: const TextSpan(children: [
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
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        )),
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
