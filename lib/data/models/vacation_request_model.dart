import 'package:cloud_firestore/cloud_firestore.dart';

class VacationRequestModel {
  final String? id;
  final String? description;
  final String? idEmployee;
  final int? autorization;
  final DateTime? dateRequest;

  final DateTime? dateVacationInit;

  VacationRequestModel({
    this.dateVacationInit,
    this.description,
    this.idEmployee,
    this.autorization,
    this.dateRequest,
    this.id,
  });

  factory VacationRequestModel.fromJson(Map<String, dynamic> map) {
    return VacationRequestModel(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      autorization: map['autorization'],
      idEmployee: map['idEmployee'] ?? '',
      dateRequest:
          (map['dateRequest'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dateVacationInit:
          (map['dateVacationInit'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'autorization': autorization,
      'idEmployee': idEmployee,
      'dateRequest': dateRequest,
      'dateVacationInit': dateVacationInit
    };
  }
}
