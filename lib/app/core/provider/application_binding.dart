import 'package:a_de_adote/app/core/rest_client/custom_dio.dart';
import 'package:a_de_adote/app/repositories/auth/auth_repository.dart';
import 'package:a_de_adote/app/repositories/auth/auth_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({super.key, required this.child});

  //TODO Criar providers para autenticação (Se necessário)
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(),
        ),
      ],
      child: child,
    );
  }
}
