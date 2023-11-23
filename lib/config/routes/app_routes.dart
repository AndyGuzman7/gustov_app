import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/routes/routes.dart';

import 'dafault.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      /* case Routes.splash:
        return _materialRoute(SplashPage());
      case Routes.login:
        return _materialRoute(const LoginPage());
      case Routes.register:
        return _materialRoute(const RegisterPage());
      case Routes.home:
        return _materialRoute(HomePage());
*/
      default:
        return _materialRoute(const Default());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
