import 'package:flutter/material.dart';

import '../../../core/constants/buttons.dart';
import '../../../core/ui/styles/project_colors.dart';
import '../../../core/ui/styles/project_fonts.dart';

class ButtonSouOng extends StatelessWidget {
  const ButtonSouOng({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(6),
      ),
      onTap: () =>
          Navigator.pushNamed(context, '/onboarding', arguments: 'ong'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          color: ProjectColors.secondary,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pets,
              size: 25,
              color: ProjectColors.light,
            ),
            SizedBox(width: 5),
            Text(
              Buttons.souOng,
              style: ProjectFonts.pLightBold,
            ),
          ],
        ),
      ),
    );
  }
}
