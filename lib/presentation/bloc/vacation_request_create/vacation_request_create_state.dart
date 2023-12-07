import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

class VacationRequestCreateState {
  final String? description;
  final List<VacationRequestEntity>? vacationRequest;
  final DateTime? dateSelected;

  final List<SettingsEntity>? settingRequests;

  const VacationRequestCreateState(
      {this.description,
      this.vacationRequest,
      this.settingRequests,
      this.dateSelected});

  VacationRequestCreateState copyWith({
    String? description,
    List<VacationRequestEntity>? vacationRequest,
    List<SettingsEntity>? settingRequests,
    DateTime? dateSelected,
  }) {
    return VacationRequestCreateState(
      description: description ?? this.description,
      vacationRequest: vacationRequest ?? this.vacationRequest,
      settingRequests: settingRequests ?? this.settingRequests,
      dateSelected: dateSelected ?? this.dateSelected,
    );
  }

  VacationRequestCreateState cleanDialog() {
    return VacationRequestCreateState(
        description: null,
        vacationRequest: vacationRequest,
        settingRequests: settingRequests,
        dateSelected: null);
  }
}
