import 'package:a_de_adote/app/core/provider/application_binding.dart';
import 'package:a_de_adote/app/core/ui/theme/theme_config.dart';
import 'package:a_de_adote/app/pages/initial/initial_page_check.dart';
import 'package:a_de_adote/app/pages/reset_password/reset_password_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/core/constantes/labels.dart';
import 'app/pages/home/main_page.dart';
import 'app/pages/login/login_router.dart';
import 'app/pages/onboarding/onboarding_screen_router.dart';
import 'app/pages/ong_register/ong_register_router.dart';
import 'app/pages/ong_space/ong_space_router.dart';

class AdeAdoteApp extends StatelessWidget {
  final SharedPreferences sp;

  const AdeAdoteApp({Key? key, required this.sp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: Labels.titulo,
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => InitialPageCheck(sp: sp),
          '/onboarding': (_) => OnboardingScreenRouter.page,
          '/register': (_) => const OngRegisterRouter(),
          '/login': (_) => LoginRouter.page,
          '/login/reset_password': (_) => ResetPasswordRouter.page,
          '/main': (_) => const MainPage(),
          '/ong_space': (_) => OngSpaceRouter.page,
        },
      ),
    );
  }
}
