import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/util/my_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/routes/app_routes.dart';
import 'config/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sytem security driver",
      theme: ThemeData(
        textTheme: GoogleFonts.ubuntuTextTheme(),
        primarySwatch: CustomColorPrimary().materialColor,
      ),
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''), // arabic, no country code
      ],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      initialRoute: Routes.splash,
    );
  }
}
