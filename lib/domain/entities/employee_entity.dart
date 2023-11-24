import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final String? id;
  final String? name;
  final String? lastName;
  final String? secondLastName;
  final String? email;
  final String? position;

  const EmployeeEntity({
    this.id,
    this.name,
    this.lastName,
    this.secondLastName,
    this.email,
    this.position,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      lastName,
      secondLastName,
      email,
      position,
    ];
  }
}
