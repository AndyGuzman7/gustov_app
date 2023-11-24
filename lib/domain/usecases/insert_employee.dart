import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/data/models/employee_model.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/repository/employee_repository.dart';

class InsertEmployeeUseCase
    implements UseCase<DataState<EmployeeEntity>, InsertEmployeeParams> {
  final EmployeeRepository _employeeRepository;

  InsertEmployeeUseCase(this._employeeRepository);
  @override
  Future<DataState<EmployeeEntity>> call({InsertEmployeeParams? params}) {
    return _employeeRepository.insert(params!.user);
  }
}

class InsertEmployeeParams {
  InsertEmployeeParams(this.user);
  final EmployeeModel user;
}
