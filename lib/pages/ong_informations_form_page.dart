import 'package:a_de_adote/pages/ong_cnpj_form_page.dart';
import 'package:a_de_adote/pages/ong_signup_form.dart';
import 'package:a_de_adote/widgets/standard_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../models/ong_model.dart';
import '../style/project_colors.dart';
import '../style/project_fonts.dart';
import '../widgets/form_button.dart';
import '../widgets/standard_appbar.dart';

class ONGInformationsFormPage extends StatefulWidget {
  final OngModel? ongModel;

  const ONGInformationsFormPage({super.key, this.ongModel});

  @override
  State<ONGInformationsFormPage> createState() =>
      _ONGInformationsFormPageState();
}

class _ONGInformationsFormPageState extends State<ONGInformationsFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeFantasia = TextEditingController();
  final _razaoSocial = TextEditingController();
  final _telefone = TextEditingController();
  final _cep = TextEditingController();
  final _logradouro = TextEditingController();
  final _numero = TextEditingController();
  final _bairro = TextEditingController();
  final _complemento = TextEditingController();
  final _cidade = TextEditingController();
  final _uf = TextEditingController();

  final maskTelFormatter = MaskTextInputFormatter(
      mask: '(xx) xxxxx-xxxx',
      filter: {'x': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final maskCEPFormatter = MaskTextInputFormatter(
      mask: 'xx.xxx-xxx',
      filter: {'x': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    _nomeFantasia.text = widget.ongModel?.fantasia ?? '';
    _razaoSocial.text = widget.ongModel?.nome ?? '';
    _telefone.text = widget.ongModel?.telefone ?? '';
    _cep.text = widget.ongModel?.cep ?? '';
    _logradouro.text = widget.ongModel?.logradouro ?? '';
    _numero.text = widget.ongModel?.numero ?? '';
    _bairro.text = widget.ongModel?.bairro ?? '';
    _complemento.text = widget.ongModel?.complemento ?? '';
    _cidade.text = widget.ongModel?.municipio ?? '';
    _uf.text = widget.ongModel?.uf ?? '';
  }

  @override
  void dispose() {
    _nomeFantasia.dispose();
    _razaoSocial.dispose();
    _telefone.dispose();
    _cep.dispose();
    _logradouro.dispose();
    _numero.dispose();
    _bairro.dispose();
    _complemento.dispose();
    _cidade.dispose();
    _uf.dispose();
    super.dispose();
  }

  void backToCNPJPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ONGCNPJFormPage(),
      ),
    );
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ONGSignUpForm(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secundary,
      appBar: StandardAppBar(
        title: 'Cadastro',
        route: backToCNPJPage,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: ProjectColors.secundary,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Essa seria a ONG?',
                              style: ProjectFonts.h4LightBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Flexible(
                              child: Text(
                                'Por favor, fique à vontade para alterar os dados caso necessário!',
                                style: ProjectFonts.h6Light,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          StandardFormInput(
                            controller: _nomeFantasia,
                            labelText: 'Nome Fantasia',
                            fullSelectionText: true,
                            mask: [LengthLimitingTextInputFormatter(50)],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe um nome válido!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _razaoSocial,
                            labelText: 'Razão Social',
                            fullSelectionText: true,
                            mask: [LengthLimitingTextInputFormatter(150)],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe uma razão social válida!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _telefone,
                            labelText: 'Telefone',
                            fullSelectionText: true,
                            mask: [maskTelFormatter],
                            inputType: TextInputType.phone,
                            validator: (value) {
                              if ((value!.isEmpty) || (value.length < 14)) {
                                return 'Informe um telefone válido!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _cep,
                            labelText: 'CEP',
                            fullSelectionText: true,
                            mask: [maskCEPFormatter],
                            inputType: TextInputType.number,
                            validator: (value) {
                              if ((value!.isEmpty) || (value.length < 10)) {
                                return 'Informe um CEP válido!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: StandardFormInput(
                                  controller: _logradouro,
                                  labelText: 'Logradouro',
                                  fullSelectionText: true,
                                  mask: [LengthLimitingTextInputFormatter(100)],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Informe um logradouro válido!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: StandardFormInput(
                                  controller: _numero,
                                  labelText: 'N°',
                                  fullSelectionText: true,
                                  mask: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  inputType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Inválido!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _bairro,
                            labelText: 'Bairro',
                            fullSelectionText: true,
                            mask: [LengthLimitingTextInputFormatter(30)],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe um bairro válido!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StandardFormInput(
                            controller: _complemento,
                            labelText: 'Complemento',
                            fullSelectionText: true,
                            mask: [LengthLimitingTextInputFormatter(100)],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: StandardFormInput(
                                  controller: _cidade,
                                  labelText: 'Cidade',
                                  fullSelectionText: true,
                                  mask: [LengthLimitingTextInputFormatter(30)],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Informe uma cidade válida!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: StandardFormInput(
                                  controller: _uf,
                                  labelText: 'UF',
                                  fullSelectionText: true,
                                  mask: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(
                                        '[a-zA-Z]',
                                      ),
                                    ),
                                    LengthLimitingTextInputFormatter(2),
                                  ],
                                  inputType: TextInputType.text,
                                  capitalization: TextCapitalization.characters,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Inválido!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FormButton(
                            formKey: _formKey,
                            text: 'CONTINUAR',
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
