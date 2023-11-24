import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

abstract class SessionRepository {
  Future<DataState<void>> saveToSession(EmployeeEntity user);
  Future<DataState<void>> removeToSession();
  Future<DataState<EmployeeEntity?>> getToSession();
}
