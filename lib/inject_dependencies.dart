import 'package:dio/dio.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.implementation/dao_employee_impl.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.implementation/dao_settings_impl.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.implementation/dao_vacation_request_impl.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.interfaces/dao_employee.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.interfaces/dao_settings.dart';
import 'package:flutter_application_gustov/data/repository_impl/authentication_repository_impl.dart';
import 'package:flutter_application_gustov/data/repository_impl/employee_repository_impl.dart';
import 'package:flutter_application_gustov/data/repository_impl/session_repository_impl.dart';
import 'package:flutter_application_gustov/data/repository_impl/settings_repository_impl.dart';
import 'package:flutter_application_gustov/data/repository_impl/vacation_request_repository_impl.dart';
import 'package:flutter_application_gustov/domain/repository/authentication_repository.dart';
import 'package:flutter_application_gustov/domain/repository/employee_repository.dart';
import 'package:flutter_application_gustov/domain/repository/session_repository.dart';
import 'package:flutter_application_gustov/domain/repository/settings_repository.dart';
import 'package:flutter_application_gustov/domain/usecases/get_employees.dart';
import 'package:flutter_application_gustov/domain/usecases/get_session.dart';
import 'package:flutter_application_gustov/domain/usecases/get_vacation_request.dart';
import 'package:flutter_application_gustov/domain/usecases/get_vacation_request_by_employee.dart';
import 'package:flutter_application_gustov/domain/usecases/insert_employee.dart';
import 'package:flutter_application_gustov/domain/usecases/insert_vacation_request.dart';
import 'package:flutter_application_gustov/domain/usecases/save_session.dart';
import 'package:flutter_application_gustov/domain/usecases/sign_employee.dart';
import 'package:flutter_application_gustov/domain/usecases/signout_session.dart';
import 'package:flutter_application_gustov/domain/usecases/signup_employee.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee_register/employee_register_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee_register/employee_register_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/splash/splash_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/data_sources/remote/dao.interfaces/dao_vacation_request.dart';
import 'domain/repository/vacation_request_repository.dart';
import 'domain/usecases/get_scale_days_vacation.dart';

final sl = GetIt.instance;
Future<void> injectDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // data
  sl.registerSingleton<DAOVactionRequest>(
    DAOVacationRequestImpl(),
  );
  sl.registerSingleton<DAOEmployee>(
    DAOEmployeeImpl(),
  );

  sl.registerSingleton<DAOSettings>(
    DAOSettingsImpl(),
  );

  // repository
  sl.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(),
  );
  sl.registerSingleton<EmployeeRepository>(
    EmployeeRepositoryImpl(sl()),
  );
  sl.registerSingleton<SessionRepository>(
    SessionRepositoryImpl(sl()),
  );

  sl.registerSingleton<VacationRequestRepository>(
    VacationRequestRepositoryImpl(sl(), sl()),
  );

  sl.registerSingleton<SettingsRepository>(
    SettingsRepositoryImpl(
      sl(),
    ),
  );

  // UseCases
  sl.registerSingleton<GetSessionUseCase>(
    GetSessionUseCase(sl()),
  );
  sl.registerSingleton<GetVacationRequestUseCase>(
    GetVacationRequestUseCase(sl()),
  );

  sl.registerSingleton<SaveSessionUseCase>(
    SaveSessionUseCase(sl()),
  );

  sl.registerSingleton<SignEmployeeUseCase>(
    SignEmployeeUseCase(
      sl(),
      sl(),
      sl(),
    ),
  );

  sl.registerSingleton<GetEmployeesUseCase>(GetEmployeesUseCase(sl()));

  sl.registerSingleton<InsertEmployeeUseCase>(InsertEmployeeUseCase(sl()));

  sl.registerSingleton<SignUpEmployeeUseCase>(
    SignUpEmployeeUseCase(
      sl(),
    ),
  );
  sl.registerSingleton<SignoutSessionUseCase>(
      SignoutSessionUseCase(sl(), sl()));
  sl.registerSingleton<GetVacationRequestByEmployeeUseCase>(
    GetVacationRequestByEmployeeUseCase(
      sl(),
    ),
  );
  sl.registerSingleton<InsertVacationRequestUseCase>(
    InsertVacationRequestUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<GetScaleDaysVacationUseCase>(
    GetScaleDaysVacationUseCase(
      sl(),
    ),
  );

  // Blocs
  sl.registerSingleton<SessionBloc>(SessionBloc());

  sl.registerFactory<SplashBloc>(
    () => SplashBloc(
      sl(),
      sl(),
    ),
  );

  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl(), sl(), sl()),
  );

  sl.registerFactory<VacationRequestBloc>(
    () => VacationRequestBloc(sl()),
  );
  sl.registerFactory<EmployeeBloc>(() => EmployeeBloc(sl()));

  sl.registerFactory<EmployeeRegisterBloc>(
    () => EmployeeRegisterBloc(
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  sl.registerFactory<VacationRequestCreateBloc>(
    () => VacationRequestCreateBloc(
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
}
