import 'package:flutter/material.dart';
import '../styles/project_colors.dart';
import '../styles/project_fonts.dart';

class FormButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String text;
  final Function()? action;
  final bool? disabled;
  final bool? isLoading;

  const FormButton({
    super.key,
    required this.formKey,
    required this.text,
    required this.action,
    this.disabled,
    this.isLoading,
  });

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
      hoverColor: !(widget.disabled ?? false)
          ? ProjectColors.primaryDark
          : const Color.fromARGB(255, 102, 102, 102),
      splashColor: !(widget.disabled ?? false) ? null : Colors.transparent,
      highlightColor: !(widget.disabled ?? false) ? null : Colors.transparent,
      onTap: widget.action,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.5),
        decoration: BoxDecoration(
          color: !(widget.disabled ?? false)
              ? ProjectColors.primary
              : const Color.fromARGB(255, 102, 102, 102).withOpacity(0.8),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (!(widget.isLoading ?? false))
                ? Text(
                    widget.text,
                    style: !(widget.disabled ?? false)
                        ? ProjectFonts.pLightBold
                        : ProjectFonts.pLightBold.copyWith(
                            color: const Color.fromARGB(255, 190, 190, 190),
                          ),
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
