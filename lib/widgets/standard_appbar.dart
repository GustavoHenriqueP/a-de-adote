import 'package:flutter/material.dart';

import '../style/project_colors.dart';
import '../style/project_fonts.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const StandardAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    //* Usando theme porque a cor do BackButton fica sempre preto se utilizado o Material 3.
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: ProjectColors.light),
        ),
        useMaterial3: false,
      ),
      child: AppBar(
        backgroundColor: ProjectColors.primary,
        title: Text(
          title,
          style: ProjectFonts.h6Light,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
