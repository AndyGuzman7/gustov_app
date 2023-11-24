import 'package:dio/dio.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.implementation/dao_vacation_request_impl.dart';
import 'package:flutter_application_gustov/data/repository_impl/vacation_request_repository_impl.dart';
import 'package:flutter_application_gustov/domain/usecases/get_vaction_request.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/data_sources/remote/dao.interfaces/dao_vacation_request.dart';
import 'domain/repository/vacation_request_repository.dart';

final sl = GetIt.instance;
Future<void> injectDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<DAOVacationRequest>(
    DAOVacationRequestImpl(),
  );

  sl.registerSingleton<VacationRequestRepository>(
    VacationRequestRepositoryImpl(sl()),
  );

  // UseCases

  sl.registerSingleton<GetVacationRequestUseCase>(
    GetVacationRequestUseCase(sl()),
  );

  // Blocs

  sl.registerFactory<VacationRequestBloc>(
    () => VacationRequestBloc(sl()),
  );
}
