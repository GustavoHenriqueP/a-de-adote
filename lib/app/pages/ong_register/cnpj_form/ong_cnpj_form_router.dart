import 'package:a_de_adote/app/pages/ong_register/cnpj_form/ong_cnpj_form_controller.dart';
import 'package:a_de_adote/app/pages/ong_register/cnpj_form/ong_cnpj_form_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../repositories/database/cache_control.dart';
import '../../../repositories/ong/ong_repository.dart';
import '../../../repositories/ong/ong_repository_impl.dart';

class OngCnpjFormRouter {
  OngCnpjFormRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OngRepository>(
            create: ((context) => OngRepositoryImpl(
                  dio: context.read(),
                  auth: context.read(),
                  cacheControl: context.read<CacheControl>(),
                )),
          ),
          Provider<OngCnpjFormController>(
            create: ((context) => OngCnpjFormController(context.read())),
          ),
        ],
        child: const ONGCNPJFormPage(),
      );
}
