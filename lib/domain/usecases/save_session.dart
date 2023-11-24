import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/domain/repository/session_repository.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class SaveSessionUseCase
    implements UseCase<DataState<void>, SaveSessionParams> {
  final SessionRepository _sessionRepository;

  SaveSessionUseCase(this._sessionRepository);
  @override
  Future<DataState<void>> call({SaveSessionParams? params}) {
    return _sessionRepository.saveToSession(params!.user);
  }
}

class SaveSessionParams {
  SaveSessionParams(this.user);
  final EmployeeEntity user;
}
