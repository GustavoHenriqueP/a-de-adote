import 'package:a_de_adote/style/project_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secundary,
      body: Center(
        child: Image.asset(
          'lib/assets/images/logos/logo_icon_white.png',
          fit: BoxFit.fill,
          width: 105,
          height: 105,
        ),
      ),
    );
  }
}
