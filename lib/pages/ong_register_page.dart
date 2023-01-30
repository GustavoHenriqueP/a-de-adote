import 'package:a_de_adote/pages/ong_cnpj_form_page.dart';
import 'package:a_de_adote/pages/ong_informations_form_page.dart';
import 'package:a_de_adote/pages/ong_signup_form.dart';
import 'package:a_de_adote/widgets/standard_appbar.dart';
import 'package:flutter/material.dart';

class OngRegisterPage extends StatefulWidget {
  const OngRegisterPage({Key? key}) : super(key: key);

  @override
  State<OngRegisterPage> createState() => _OngRegisterPageState();
}

class _OngRegisterPageState extends State<OngRegisterPage> {
  var navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPopRegister = navKey.currentState?.canPop() ?? false;
        if (canPopRegister) {
          navKey.currentState?.pop();
          return false;
        } else {
          Navigator.of(context, rootNavigator: true).popUntil(ModalRoute.withName('/'));
          return true;
        }
      },
      child: Scaffold(
          appBar: const StandardAppBar(title: 'Cadastro'),
          body: Navigator(
            key: navKey,
            initialRoute: '/cnpj',
            onGenerateRoute: (settings) {
              var route = settings.name;
              Widget page;
              switch (route) {
                case '/cnpj':
                  page = const ONGCNPJFormPage();
                  break;
                case '/informacoes':
                  page = const ONGInformationsFormPage();
                  break;
                case '/usuario':
                  page = const ONGSignUpForm();
                  break;
                default:
                  return null;
              }
              return MaterialPageRoute(
                builder: (context) => page,
                settings: settings,
              );
            },
          )),
    );
  }
}
