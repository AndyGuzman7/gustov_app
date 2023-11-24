import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/domain/repository/authentication_repository.dart';
import 'package:flutter_application_gustov/domain/repository/session_repository.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class SignoutSessionUseCase implements UseCase<DataState<void>, void> {
  final SessionRepository _sessionRepository;
  final AuthenticationRepository _authenticationRepository;

  SignoutSessionUseCase(
    this._sessionRepository,
    this._authenticationRepository,
  );
  @override
  Future<DataState<void>> call({void params}) async {
    await _authenticationRepository.signOut();
    return await _sessionRepository.removeToSession();
  }
}
