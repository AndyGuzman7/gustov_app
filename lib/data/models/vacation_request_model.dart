import 'package:flutter_application_gustov/data/models/employee_model.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

class VacationRequestModel extends VacationRequestEntity {
  const VacationRequestModel({
    String? id,
    String? description,
    String? idEmployee,
    bool? autorization,
  }) : super(
          id: id,
          description: description,
          autorizationVacation: autorization,
        );

  factory VacationRequestModel.fromJson(Map<String, dynamic> map) {
    return VacationRequestModel(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      autorization: map['autorization'],
      idEmployee: map['idEmployee'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'autorization': autorizationVacation,
      'idEmployee': employeeEntity!.id,
    };
  }
}
