import 'package:a_de_adote/app/core/bloc/auth/auth_controller.dart';
import 'package:a_de_adote/app/pages/ong_register/signup_form/ong_signup_form.dart';
import 'package:a_de_adote/app/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../repositories/ong/ong_repository.dart';
import '../../../repositories/ong/ong_repository_impl.dart';

class OngSignupRouter {
  OngSignupRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OngRepository>(
            create: ((context) => OngRepositoryImpl(
                  dio: context.read(),
                )),
          ),
          Provider<AuthController>(
            create: ((context) => AuthController(
                  context.read<AuthRepository>(),
                  context.read(),
                )),
          ),
        ],
        child: const ONGSignUpForm(),
      );
}
