import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/core/ui/styles/project_colors.dart';
import 'app/pages/home/main_page.dart';
import 'app/pages/initial/initial_page_animation.dart';
import 'app/pages/login/login_page.dart';
import 'app/pages/onboarding/onboarding_screen.dart';
import 'app/pages/ong_register/ong_register_router.dart';

class AdeAdoteApp extends StatelessWidget {
  const AdeAdoteApp({Key? key}) : super(key: key);

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
        '/register': (_) => const OngRegisterRouter(),
        '/login': (_) => const LoginPage(),
        '/main': (_) => const MainPage(),
      },
    );
  }
}
