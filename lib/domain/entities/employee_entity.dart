import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final String? id;
  final String? name;
  final String? lastName;
  final String? secondLastName;
  final String? email;
  final String? position;
  final String? uid;
  final String? password;
  final DateTime? workStartDate;
  const EmployeeEntity({
    this.id,
    this.name,
    this.lastName,
    this.secondLastName,
    this.email,
    this.position,
    this.uid,
    this.password,
    this.workStartDate,
  });
  String get fullName {
    final List<String?> nameParts = [name, lastName, secondLastName];
    final filteredNameParts = nameParts.where((part) => part != null).toList();
    return filteredNameParts.join(' ');
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      lastName,
      secondLastName,
      email,
      position,
      uid,
      workStartDate
    ];
  }
}
