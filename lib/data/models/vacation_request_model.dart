import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

class VacationRequestModel extends VacationRequestEntity {
  const VacationRequestModel({
    String? id,
    String? description,
  });

  factory VacationRequestModel.fromJson(Map<String, dynamic> map) {
    return VacationRequestModel(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description};
  }
}
