import 'package:a_de_adote/models/ong_model.dart';
import 'package:a_de_adote/pages/initial_page_animation.dart';
import 'package:a_de_adote/pages/ong_informations_form_page.dart';
import 'package:a_de_adote/repositories/ong_repository.dart';
import 'package:a_de_adote/style/project_colors.dart';
import 'package:a_de_adote/style/project_fonts.dart';
import 'package:a_de_adote/widgets/form_button.dart';
import 'package:a_de_adote/widgets/standard_appbar.dart';
import 'package:a_de_adote/widgets/standard_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../repositories/ong_repository_impl.dart';

class ONGCNPJFormPage extends StatefulWidget {
  const ONGCNPJFormPage({super.key});

  @override
  State<ONGCNPJFormPage> createState() => _ONGCNPJFormPageState();
}

class _ONGCNPJFormPageState extends State<ONGCNPJFormPage> {
  final OngRepository ongRepository = OngRepositoryImpl();
  OngModel? ongModel;
  final _formKey = GlobalKey<FormState>();
  final _cnpj = TextEditingController();
  var _isLoading = false;

  final maskCNPJFormatter = MaskTextInputFormatter(
      mask: 'xx.xxx.xxx/xxxx-xx',
      filter: {'x': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void backToInitialPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const InitialPageAnimation(),
      ),
    );
  }

  void salvar() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      try {
        setState(() {
          _isLoading = true;
        });
        final ong = await ongRepository.getOng(
          _cnpj.text.replaceAll(RegExp(r'[^0-9]'), ''),
        );
        setState(() {
          _isLoading = false;
          ongModel = ong;
        });
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ONGInformationsFormPage(
              ongModel: ongModel,
            ),
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
          ongModel = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().substring(11)),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _cnpj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO Passar gerência de estado para Bloc
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
            physics: const BouncingScrollPhysics(),
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
                          StandardFormInput(
                            controller: _cnpj,
                            labelText: 'CNPJ',
                            mask: [maskCNPJFormatter],
                            inputType: TextInputType.number,
                            validator: (value) {
                              if ((value!.isEmpty) || (value.length < 18)) {
                                return 'Informe um CNPJ válido!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FormButton(
                            formKey: _formKey,
                            text: 'CONTINUAR',
                            action: salvar,
                            isLoading: _isLoading,
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
