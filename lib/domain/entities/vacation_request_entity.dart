import 'package:equatable/equatable.dart';
import 'package:flutter_application_gustov/data/models/vacation_request_model.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

class VacationRequestEntity extends Equatable {
  final String? id;
  final String? description;
  final EmployeeEntity? employeeEntity;
  final int? autorizationVacation;
  final DateTime? dateRequest;
  final String? idEmployee;
  final DateTime? dateVacationInit;

  const VacationRequestEntity(
      {this.id,
      this.idEmployee,
      this.description,
      this.employeeEntity,
      this.autorizationVacation,
      this.dateRequest,
      this.dateVacationInit});

  factory VacationRequestEntity.fromModel(
    VacationRequestModel model,
    EmployeeEntity employeeEntity,
  ) {
    return VacationRequestEntity(
        id: model.id,
        idEmployee: model.idEmployee,
        description: model.description,
        dateRequest: model.dateRequest,
        autorizationVacation: model.autorization,
        employeeEntity: employeeEntity,
        dateVacationInit: model.dateVacationInit);
  }

  @override
  List<Object?> get props {
    return [
      id,
      description,
      employeeEntity,
      autorizationVacation,
      dateRequest,
      idEmployee,
    ];
  }
}
