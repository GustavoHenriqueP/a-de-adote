import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  ThemeConfig._();

  static final theme = ThemeData(
    scaffoldBackgroundColor: ProjectColors.secondary,
    primaryColor: ProjectColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ProjectColors.primary,
      primary: ProjectColors.primary,
      secondary: ProjectColors.secondary,
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
    useMaterial3: true,
  );
}
