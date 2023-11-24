import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<DataState<List<EmployeeEntity>>> getEmployees();
  Future<DataState<EmployeeEntity>> getEmployeeById(String id);

  Future<DataState<EmployeeEntity>> getByType(String field, String type);
}
