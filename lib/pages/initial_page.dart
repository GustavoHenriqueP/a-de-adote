import 'package:a_de_adote/pages/login_page.dart';
import 'package:a_de_adote/style/project_colors.dart';
import 'package:a_de_adote/style/project_fonts.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  loginOng() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background/initial_page_dog.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.1),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 125, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Image.asset(
                        'assets/images/logos/logo_completo_withblue.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              //width: 185,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: const BoxDecoration(
                                color: ProjectColors.primary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
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
                                  Navigator.pop(context);
                                  loginOng();
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
      ),
    );
  }
}
