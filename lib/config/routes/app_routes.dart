import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/routes/routes.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_bloc.dart';
import 'package:flutter_application_gustov/presentation/pages/employee_page/employee_page.dart';
import 'package:flutter_application_gustov/presentation/pages/employee_register_page/employee_register_.dart';
import 'package:flutter_application_gustov/presentation/pages/home_page/home_page.dart';
import 'package:flutter_application_gustov/presentation/pages/login_page/login_page.dart';
import 'package:flutter_application_gustov/presentation/pages/splash_page/splash_page.dart';
import 'package:flutter_application_gustov/presentation/pages/vacation_request_create_page/vacation_request_create_page.dart';
import 'package:flutter_application_gustov/presentation/pages/vacation_request_page/vacation_request_page.dart';

import 'dafault.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _materialRoute(SplashPage());
      case Routes.login:
        return _materialRoute(LoginPage());

      case Routes.employee:
        return _materialRoute(EmployeePage());
      case Routes.home:
        return _materialRoute(const HomePage());
      case Routes.employeesRegister:
        return _materialRoute(EmployeeRegisterPage());
      case Routes.requestVacation:
        return _materialRoute(VacationRequestPage());

      case Routes.requestVacationCreate:
        return _materialRoute(VacationRequestCreatePage());
      default:
        return _materialRoute(const Default());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
