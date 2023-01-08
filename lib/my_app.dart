import 'package:a_de_adote/pages/initial_page.dart';
import 'package:a_de_adote/pages/login_page.dart';
import 'package:a_de_adote/style/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ProjectColors.primary,
        fontFamily: GoogleFonts.roboto().fontFamily
      ),
      home: const InitialPage(),
    );
  }
}