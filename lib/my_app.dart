import 'package:a_de_adote/pages/initial_page_animation.dart';
import 'package:a_de_adote/pages/login_page.dart';
import 'package:a_de_adote/pages/main_page.dart';
import 'package:a_de_adote/pages/onboarding_screen.dart';
import 'package:a_de_adote/pages/ong_register_page.dart';
import 'package:a_de_adote/style/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A de Adote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ProjectColors.primary,
        fontFamily: GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const InitialPageAnimation(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/register': (_) => const OngRegisterPage(),
        '/login': (_) => const LoginPage(),
        '/main': (_) => const MainPage(),
      },
    );
  }
}
