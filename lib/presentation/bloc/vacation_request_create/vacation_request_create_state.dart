import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

class VacationRequestCreateState {
  final String? description;
  final List<VactionRequestEntity>? vacationRequest;

  final List<SettingsEntity>? settingRequests;

  const VacationRequestCreateState({
    this.description,
    this.vacationRequest,
    this.settingRequests,
  });

  VacationRequestCreateState copyWith({
    String? description,
    List<VactionRequestEntity>? vacationRequest,
    List<SettingsEntity>? settingRequests,
  }) {
    return VacationRequestCreateState(
      description: description ?? this.description,
      vacationRequest: vacationRequest ?? this.vacationRequest,
      settingRequests: settingRequests ?? this.settingRequests,
    );
  }
}
