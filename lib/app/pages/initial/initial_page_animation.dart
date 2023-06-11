import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/pages/initial/widgets/button_sou_adotante.dart';
import 'package:a_de_adote/app/pages/initial/widgets/button_sou_ong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/ui/styles/project_colors.dart';
import '../../core/ui/styles/project_fonts.dart';
import 'widgets/initial_animation.dart';

class InitialPageAnimation extends StatelessWidget {
  const InitialPageAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.secondaryLight,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: ProjectColors.secondaryLight,
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ProjectColors.secondary,
                ProjectColors.secondaryLight,
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.02),
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
                      Flexible(
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: Labels.boasVindas,
                                style: ProjectFonts.h5LightBold,
                              ),
                              TextSpan(
                                text: Labels.selecioneOpcao,
                                style: ProjectFonts.h6Light,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Visibility(
                      visible: MediaQuery.textScaleFactorOf(context) > 1 ||
                          MediaQuery.devicePixelRatioOf(context) > 2.75,
                      replacement: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ButtonSouAdotante(),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ButtonSouOng(),
                          ),
                        ],
                      ),
                      child: const Wrap(
                        spacing: 15,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: [
                          ButtonSouAdotante(),
                          ButtonSouOng(),
                        ],
                      ),
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
