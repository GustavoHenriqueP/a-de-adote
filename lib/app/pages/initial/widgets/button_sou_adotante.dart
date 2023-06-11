import 'package:flutter/material.dart';

import '../../../core/constants/buttons.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';

class ButtonSouAdotante extends StatelessWidget {
  const ButtonSouAdotante({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(6),
      ),
      onTap: () =>
          Navigator.pushNamed(context, '/onboarding', arguments: 'adotante'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          color: ProjectColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              size: 25,
              color: ProjectColors.light,
            ),
            SizedBox(width: 5),
            Text(
              Buttons.souAdotante,
              style: ProjectFonts.pLightBold,
            ),
          ],
        ),
      ),
    );
  }
}
