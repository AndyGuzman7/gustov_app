import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/repository/session_repository.dart';

class GetSessionUseCase implements UseCase<DataState<EmployeeEntity?>, void> {
  final SessionRepository _sessionRepository;

  GetSessionUseCase(this._sessionRepository);
  @override
  Future<DataState<EmployeeEntity?>> call({void params}) {
    return _sessionRepository.getToSession();
  }
}
