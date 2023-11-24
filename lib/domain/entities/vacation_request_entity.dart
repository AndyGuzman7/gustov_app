import 'package:equatable/equatable.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

class VacationRequestEntity extends Equatable {
  final String? id;
  final String? description;
  final EmployeeEntity? employeeEntity;
  final bool? autorizationVacation;

  const VacationRequestEntity({
    this.id,
    this.description,
    this.employeeEntity,
    this.autorizationVacation,
  });

  @override
  List<Object?> get props {
    return [
      id,
      description,
      employeeEntity,
      autorizationVacation,
    ];
  }
}
