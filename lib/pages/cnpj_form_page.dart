import 'package:a_de_adote/pages/initial_page_animation.dart';
import 'package:a_de_adote/style/project_colors.dart';
import 'package:a_de_adote/style/project_fonts.dart';
import 'package:a_de_adote/widgets/cnpj_form_input.dart';
import 'package:a_de_adote/widgets/form_button.dart';
import 'package:a_de_adote/widgets/form_input.dart';
import 'package:a_de_adote/widgets/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CNPJFormPage extends StatefulWidget {
  const CNPJFormPage({super.key});

  @override
  State<CNPJFormPage> createState() => _CNPJFormPageState();
}

class _CNPJFormPageState extends State<CNPJFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _cnpj = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void backToInitialPage() {
      Navigator.pop(context);
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const InitialPageAnimation() ,
      ),
    );
    }

    return Scaffold(
      backgroundColor: ProjectColors.secundary,
      appBar: StandardAppBar(
        title: 'Cadastro',
        route: backToInitialPage,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: ProjectColors.secundary,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2.5,
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
                              'Vamos começar!',
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
                              'Insira abaixo o CNPJ da ONG',
                              style: ProjectFonts.h5LightBold,
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
                          CNPJFormInput(
                            controller: _cnpj,
                            labelText: 'CNPJ',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FormButton(
                            formKey: _formKey,
                            text: 'CONTINUAR',
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
