import 'dart:async';

import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/extensions/mask_formatters.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';
import '../../../models/ong_model.dart';
import '../../constants/labels.dart';
import '../widgets/standard_form_input.dart';

mixin UpdateDialogOngData<T extends StatefulWidget> on State<T> {
  final _formKey = GlobalKey<FormState>();
  final _nomeFantasia = TextEditingController();
  final _telefone = TextEditingController();
  final _whatsapp = TextEditingController();
  final _cep = TextEditingController();
  final _logradouro = TextEditingController();
  final _numero = TextEditingController();
  final _bairro = TextEditingController();
  final _complemento = TextEditingController();
  final _cidade = TextEditingController();
  final _uf = TextEditingController();

  @override
  void dispose() {
    _nomeFantasia.dispose();
    _telefone.dispose();
    _whatsapp.dispose();
    _cep.dispose();
    _logradouro.dispose();
    _numero.dispose();
    _bairro.dispose();
    _complemento.dispose();
    _cidade.dispose();
    _uf.dispose();
    super.dispose();
  }

  Future<OngModel?> showChangeOngData(OngModel ong) async {
    OngModel? updatedOng;

    _nomeFantasia.text = ong.fantasia;
    _telefone.text = ong.telefone ?? '';
    _whatsapp.text = ong.whatsapp ?? '';
    _cep.text = ong.cep ?? '';
    _logradouro.text = ong.logradouro ?? '';
    _numero.text = ong.numero ?? '';
    _bairro.text = ong.bairro ?? '';
    _complemento.text = ong.complemento ?? '';
    _cidade.text = ong.municipio;
    _uf.text = ong.uf;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ProjectColors.secondary,
        surfaceTintColor: ProjectColors.secondary,
        titlePadding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 24,
          bottom: 0,
        ),
        title: const Text(
          Labels.atualizarInfoOng,
          style: ProjectFonts.pLightBold,
        ),
        contentPadding: const EdgeInsets.all(10),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  StandardFormInput(
                    controller: _nomeFantasia,
                    labelText: Labels.nomeFantasia,
                    mask: [LengthLimitingTextInputFormatter(50)],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Labels.nomeValido;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StandardFormInput(
                    controller: _telefone,
                    labelText: Labels.tel,
                    mask: [context.maskFormatters.maskTelFormatter],
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StandardFormInput(
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
                    validator: Validatorless.required(Labels.whatsAppValido),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StandardFormInput(
                    controller: _cep,
                    labelText: Labels.cep,
                    mask: [context.maskFormatters.maskCEPFormatter],
                    inputType: TextInputType.number,
                    validator: (value) {
                      if ((value!.isEmpty) || (value.length < 10)) {
                        return Labels.cepValido;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StandardFormInput(
                    controller: _logradouro,
                    labelText: Labels.logradouro,
                    mask: [LengthLimitingTextInputFormatter(100)],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Labels.logValido;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StandardFormInput(
                    controller: _numero,
                    labelText: Labels.n,
                    mask: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    inputType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Labels.invalido;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StandardFormInput(
                    controller: _bairro,
                    labelText: Labels.bairro,
                    mask: [LengthLimitingTextInputFormatter(30)],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Labels.bairroValido;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StandardFormInput(
                    controller: _complemento,
                    labelText: Labels.complemento,
                    mask: [LengthLimitingTextInputFormatter(100)],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: StandardFormInput(
                          controller: _cidade,
                          labelText: Labels.cidade,
                          mask: [LengthLimitingTextInputFormatter(30)],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return Labels.cidadeValida;
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
                          labelText: Labels.uf,
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
                              return Labels.invalido;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        actions: [
          TextButton(
            onPressed: () {
              final valid = _formKey.currentState?.validate() ?? false;
              if (valid) {
                FocusManager.instance.primaryFocus?.unfocus();
                updatedOng = ong.copyWith(
                  fantasia: _nomeFantasia.text,
                  telefone: _telefone.text,
                  whatsapp: _whatsapp.text,
                  cep: _cep.text,
                  logradouro: _logradouro.text,
                  numero: _numero.text,
                  bairro: _bairro.text,
                  complemento: _complemento.text,
                  municipio: _cidade.text,
                  uf: _uf.text,
                );
                Timer(
                  const Duration(milliseconds: 100),
                  () => Navigator.of(context).pop(),
                );
              }
            },
            child: Text(
              Buttons.salvar,
              style: ProjectFonts.pSecundaryDark.copyWith(
                color: ProjectColors.primaryLight,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              Buttons.cancelar,
              style: ProjectFonts.pSecundaryDark.copyWith(
                color: ProjectColors.lightDark,
              ),
            ),
          ),
        ],
      ),
    );
    return updatedOng;
  }
}
