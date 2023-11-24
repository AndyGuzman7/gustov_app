import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    final String? id,
    final String? name,
    final String? lastName,
    final String? secondLastName,
    final String? email,
    final String? position,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'secondLastName': secondLastName,
      'email': email,
      'position': position,
    };
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      secondLastName: json['secondLastName'],
      email: json['email'],
      position: json['position'],
    );
  }
}
