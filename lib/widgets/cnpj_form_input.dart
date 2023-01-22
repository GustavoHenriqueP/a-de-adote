import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../style/project_colors.dart';
import '../style/project_fonts.dart';

class CNPJFormInput extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const CNPJFormInput(
      {super.key, required this.controller, required this.labelText});

  @override
  State<CNPJFormInput> createState() => _CNPJFormInputState();
}

class _CNPJFormInputState extends State<CNPJFormInput> {
  final maskCNPJFormatter = MaskTextInputFormatter(
      mask: 'xx.xxx.xxx/xxxx-xx',
      filter: {'x': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: ProjectFonts.pLight,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          borderSide: BorderSide(
            color: ProjectColors.light,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          borderSide: BorderSide(
            color: ProjectColors.danger,
          ),
        ),
        isCollapsed: true,
        contentPadding: const EdgeInsets.only(left: 14, top: 16, bottom: 16),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        filled: true,
        fillColor: ProjectColors.light.withOpacity(0.2),
        hintText: '00.000.000/0000-00',
        hintStyle: const TextStyle(
          color: ProjectColors.secundaryLight,
        ),
        labelText: widget.labelText,
        labelStyle: ProjectFonts.pLight,
        errorStyle: const TextStyle(
          color: ProjectColors.danger,
          fontWeight: FontWeight.bold,
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [maskCNPJFormatter],
      validator: (value) {
        if ((value!.isEmpty) || (value.length < 14)) {
          return 'Informe um CNPJ válido!';
        }
        return null;
      },
    );
  }
}
