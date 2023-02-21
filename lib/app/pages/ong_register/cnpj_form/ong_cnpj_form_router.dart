import 'package:a_de_adote/app/pages/ong_register/cnpj_form/ong_cnpj_form_controller.dart';
import 'package:a_de_adote/app/pages/ong_register/cnpj_form/ong_cnpj_form_page.dart';
import 'package:a_de_adote/app/repositories/ong_repository.dart';
import 'package:a_de_adote/app/repositories/ong_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OngCnpjFormRouter {
  OngCnpjFormRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OngRepository>(
            create: ((context) => OngRepositoryImpl(
                  dio: context.read(),
                )),
          ),
          Provider<OngCnpjFormController>(
            create: ((context) => OngCnpjFormController(context.read())),
          ),
        ],
        child: const ONGCNPJFormPage(),
      );
}
