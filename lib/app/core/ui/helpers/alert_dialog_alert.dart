import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../constants/buttons.dart';

mixin AlertDialogAlert<T extends StatefulWidget> on State<T> {
  Future<void> showAlert(String message, bool? alertIcon) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: !(alertIcon ?? true)
            ? null
            : const Icon(
                MaterialCommunityIcons.alert_circle_outline,
                size: 32,
                color: ProjectColors.danger,
              ),
        content: Text(
          message,
          style: ProjectFonts.pSecundaryDark,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              Buttons.ok,
              style: ProjectFonts.pSecundaryDark.copyWith(
                color: ProjectColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
