import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({
    required String id,
    required String name,
    required String lastName,
    required String secondLastName,
    required String email,
    required String position,
    required String uid,
    required String password,
    required DateTime workStartDate,
  }) : super(
          id: id,
          name: name,
          lastName: lastName,
          secondLastName: secondLastName,
          email: email,
          position: position,
          uid: uid,
          password: password,
          workStartDate: workStartDate,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'secondLastName': secondLastName,
      'email': email,
      'position': position,
      'uid': uid,
      'workStartDate': workStartDate,
    };
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    final user = EmployeeModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      lastName: json['lastName'] ?? "",
      secondLastName: json['secondLastName'] ?? "",
      email: json['email'] ?? "",
      position: json['position'] ?? "",
      uid: json['uid'] ?? "",
      password: "",
      workStartDate:
          (json['birthDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );

    return user;
  }

  factory EmployeeModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    return EmployeeModel.fromJson(data!);
  }
}
