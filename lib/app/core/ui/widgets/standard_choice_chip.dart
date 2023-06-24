import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';

class StandardChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Widget? avatar;
  final Color? backgroundColor;
  final Color? selectedColor;
  final void Function(bool?)? choiceChipCallback;

  const StandardChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    this.avatar,
    this.backgroundColor,
    this.selectedColor,
    required this.choiceChipCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: !selected ? avatar : null,
      label: Text(
        label,
        style: ProjectFonts.smallSecundaryDark,
      ),
      selected: selected,
      onSelected: choiceChipCallback,
      side: BorderSide.none,
      backgroundColor: backgroundColor ?? ProjectColors.lightDark,
      selectedColor: selectedColor ?? ProjectColors.primary.withOpacity(0.4),
    );
  }
}
