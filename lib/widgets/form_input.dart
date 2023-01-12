import 'package:flutter/material.dart';

import '../style/project_colors.dart';
import '../style/project_fonts.dart';

class FormInput extends StatefulWidget {
  final String type;
  final TextEditingController controller;
  final String labelText;

  const FormInput(
      {super.key,
      required this.type,
      required this.controller,
      required this.labelText});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  bool visibility = true;
  bool senhaFocused = false;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {
          setState(() {
            senhaFocused = focus;
          });
        },
        child: TextFormField(
          controller: widget.controller,
          style: ProjectFonts.pLight,
          decoration: InputDecoration(
            suffixIcon: widget.type == 'login'
                ? null
                : IconButton(
                    color: senhaFocused
                        ? ProjectColors.lightDark
                        : ProjectColors.darkLight,
                    icon: (visibility)
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: (() {
                      setState(() {
                        visibility = visibility == true ? false : true;
                      });
                    })),
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
            contentPadding:
                const EdgeInsets.only(left: 14, top: 16, bottom: 16),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            filled: true,
            fillColor: ProjectColors.light.withOpacity(0.2),
            labelText: widget.labelText,
            labelStyle: ProjectFonts.pLight,
            errorStyle: const TextStyle(
              color: ProjectColors.danger,
              fontWeight: FontWeight.bold,
            ),
          ),
          obscureText: (widget.type == 'login') ? false : visibility,
          keyboardType:
              (widget.type == 'login') ? TextInputType.emailAddress : null,
          validator: (value) {
            if (widget.type == 'login') {
              if (value!.isEmpty) {
                return 'Informe um e-mail válido!';
              }
            } else if (widget.type == 'senha') {
              if (value!.isEmpty || value.length < 6) {
                return 'Informe uma senha válida!';
              }
            }
            return null;
          },
        ),
      ),
    );
  }
}
