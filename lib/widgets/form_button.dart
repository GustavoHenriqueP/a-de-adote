import 'package:flutter/material.dart';

import '../style/project_colors.dart';

class FormButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String text;

  const FormButton({super.key, required this.formKey, required this.text});

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          if (widget.formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (!isLoading)
              ? Text(
                  widget.text,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ProjectColors.light),
                )
              : const SizedBox(
                  height: 16,
                  width: 16,
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
