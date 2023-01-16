import 'package:a_de_adote/style/project_colors.dart';
import 'package:a_de_adote/style/project_fonts.dart';
import 'package:a_de_adote/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pc = PageController(initialPage: 0);
  int _currentPage = 0;

  loginOng() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  AnimatedContainer _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive
            ? ProjectColors.light
            : ProjectColors.light.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            systemNavigationBarColor: ProjectColors.secundaryLight),
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
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, bottom: 10, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        ProjectColors.primary.withOpacity(0.2),
                      ),
                    ),
                    onPressed: () => _pc.animateToPage(
                      _numPages - 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    ),
                    child: const Text(
                      'PULAR',
                      style: ProjectFonts.smallLightBold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 590,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pc,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/logos/logo_icon_white_450.png',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Veja cada animalzinho disponível nas ONGs\nmais próximas de você',
                              style: ProjectFonts.h5LightBold,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Lorem Ipsum' * 8,
                              style: ProjectFonts.pLight,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/logos/logo_icon_white_450.png',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Veja cada animalzinho disponível nas ONGs mais próximas de você',
                              style: ProjectFonts.h5LightBold,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Lorem Ipsum' * 8,
                              style: ProjectFonts.pLight,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/logos/logo_icon_white_450.png',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Veja cada animalzinho disponível nas ONGs mais próximas de você',
                              style: ProjectFonts.h5LightBold,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Lorem Ipsum' * 8,
                              style: ProjectFonts.pLight,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                ProjectColors.primary.withOpacity(0.2),
                              ),
                            ),
                            onPressed: () => _pc.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'PRÓXIMO',
                                  style: ProjectFonts.pLightBold,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: ProjectColors.light,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 25, right: 25),
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: AnimatedButton(
                              route: loginOng,
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
