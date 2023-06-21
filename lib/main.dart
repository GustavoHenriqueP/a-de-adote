import 'package:a_de_adote/app/repositories/database/cache_control.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'a_de_adote_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    await CacheControl.initializingCacheControl();
  } catch (_) {
  } finally {
    final sp = await SharedPreferences.getInstance();
    runApp(AdeAdoteApp(sp: sp));
  }
}
