import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../style/project_colors.dart';
import '../style/project_fonts.dart';
import '../widgets/initial_animation.dart';

class InitialPageAnimation extends StatefulWidget {
  const InitialPageAnimation({super.key});

  @override
  State<InitialPageAnimation> createState() => _InitialPageAnimationState();
}

class _InitialPageAnimationState extends State<InitialPageAnimation>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secundaryLight,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: ProjectColors.secundaryLight,
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ProjectColors.secundary,
                  ProjectColors.secundaryLight,
                ]),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 125, bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Image.asset(
                      'assets/images/logos/logo_completo_white.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const InitalAnimation(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Que bom te ver!\n',
                              style: ProjectFonts.h5LightBold,
                            ),
                            TextSpan(
                              text: 'Por favor, selecione uma das opções',
                              style: ProjectFonts.h6Light,
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: const BoxDecoration(
                              color: ProjectColors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              onTap: (() {
                                Navigator.pushNamed(context, '/onboarding', arguments: 'adotante');
                              }),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.favorite,
                                    size: 25,
                                    color: ProjectColors.light,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'SOU ADOTANTE',
                                    style: ProjectFonts.pLightBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: const BoxDecoration(
                              color: ProjectColors.secundary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              onTap: (() {
                                Navigator.pushNamed(context, '/onboarding', arguments: 'ong');
                              }),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.pets,
                                    size: 25,
                                    color: ProjectColors.light,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'SOU UMA ONG',
                                    style: ProjectFonts.pLightBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
