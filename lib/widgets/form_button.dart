import 'package:flutter/material.dart';

import '../style/project_colors.dart';
import '../style/project_fonts.dart';

class FormButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String text;
  final Function()? action;
  bool? isLoading;

  FormButton({
    super.key,
    required this.formKey,
    required this.text,
    required this.action,
    this.isLoading,
  });

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.5),
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
        onTap: widget.action,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (!(widget.isLoading ?? false))
                ? Text(
                    widget.text,
                    // ignore: prefer_const_constructors
                    style: ProjectFonts.pLightBold,
                  )
                : const SizedBox(
                    height: 23,
                    width: 23,
                    child: CircularProgressIndicator(
                      color: ProjectColors.light,
                      strokeWidth: 2,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
