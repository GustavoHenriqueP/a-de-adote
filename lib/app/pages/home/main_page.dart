import 'package:flutter/material.dart';
import '../../core/ui/styles/project_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //TODO Não permitir voltar para a tela de onboarding ao clicar o BackButton
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
