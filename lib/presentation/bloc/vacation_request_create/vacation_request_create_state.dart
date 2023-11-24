import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

class VacationRequestCreateState {
  final String? description;
  final List<VacationRequestEntity>? vacationRequest;

  const VacationRequestCreateState({this.description, this.vacationRequest});

  VacationRequestCreateState copyWith({
    String? description,
    List<VacationRequestEntity>? vacationRequest,
  }) {
    return VacationRequestCreateState(
      description: description ?? this.description,
      vacationRequest: vacationRequest ?? this.vacationRequest,
    );
  }
}
