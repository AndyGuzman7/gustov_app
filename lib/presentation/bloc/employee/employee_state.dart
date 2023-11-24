import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

abstract class EmployeeState extends Equatable {
  final List<EmployeeEntity>? employees;
  final DioException? error;

  const EmployeeState({this.employees, this.error});

  @override
  List<Object?> get props => [employees!, error!];
}

class EmployeeLoading extends EmployeeState {
  const EmployeeLoading();
}

class EmployeeDone extends EmployeeState {
  const EmployeeDone(List<EmployeeEntity>? employees)
      : super(
          employees: employees,
        );
}

class EmployeeError extends EmployeeState {
  const EmployeeError(
    DioException error,
  ) : super(
          error: error,
        );
}
