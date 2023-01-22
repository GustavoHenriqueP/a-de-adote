import 'package:flutter/material.dart';

import '../style/project_colors.dart';
import '../style/project_fonts.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? route;

  const StandardAppBar({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ProjectColors.primary,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: ProjectColors.light,
        ),
        onPressed: route,
      ),
      title: Text(
        title,
        style: ProjectFonts.h6Light,
      ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
