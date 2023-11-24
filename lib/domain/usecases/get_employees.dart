import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/repository/employee_repository.dart';
import 'package:flutter_application_gustov/domain/repository/session_repository.dart';

class GetEmployeesUseCase
    implements UseCase<DataState<List<EmployeeEntity>>, void> {
  final EmployeeRepository _employeeRepository;

  GetEmployeesUseCase(this._employeeRepository);
  @override
  Future<DataState<List<EmployeeEntity>>> call({void params}) {
    return _employeeRepository.getEmployees();
  }
}
