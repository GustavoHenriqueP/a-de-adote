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
  LoginOng() {
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
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: Column(
                        children: [
                          Container(
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
                                  Icons.favorite_outline_outlined,
                                  size: 50,
                                  color: ProjectColors.light,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'SOU ADOTANTE',
                                  style: ProjectFonts.h6LightBold/*TextStyle(
                                      fontSize: 19.2,
                                      fontWeight: FontWeight.bold,
                                      color: ProjectColors.light)*/,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
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
                                LoginOng();
                              }),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.home_outlined,
                                    size: 50,
                                    color: ProjectColors.light,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'SOU UMA ONG',
                                    style: ProjectFonts.h6LightBold/*TextStyle(
                                        fontSize: 19.2,
                                        fontWeight: FontWeight.bold,
                                        color: ProjectColors.light)*/,
                                  ),
                                ],
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
