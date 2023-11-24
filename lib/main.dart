import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'inject_dependencies.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    print(details);
    if (kReleaseMode) exit(1);
  };
  injectDependencies();
  runApp(const MyApp());
}
