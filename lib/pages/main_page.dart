import 'package:a_de_adote/style/project_colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ProjectColors.lightDark,
      body: Center(
        child: Text('MainPage'),
      ),
    );
  }
}
