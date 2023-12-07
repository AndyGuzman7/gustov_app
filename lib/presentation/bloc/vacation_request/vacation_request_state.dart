import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

import '../../../domain/entities/settings_entity.dart';

class VacationRequestState extends Equatable {
  final List<VacationRequestEntity>? vacationRequest;
  final DioException? error;
  final List<SettingsEntity>? settingRequests;
  const VacationRequestState({
    this.vacationRequest,
    this.error,
    this.settingRequests,
  });
  VacationRequestState copyWith({
    final DioException? error,
    List<VacationRequestEntity>? vacationRequest,
    List<SettingsEntity>? settingRequests,
  }) {
    return VacationRequestState(
      error: error ?? this.error,
      vacationRequest: vacationRequest ?? this.vacationRequest,
      settingRequests: settingRequests ?? this.settingRequests,
    );
  }

  @override
  List<Object?> get props => [vacationRequest!, error!];
}

class VacationRequestLoading extends VacationRequestState {
  const VacationRequestLoading();
}

class VacationRequestDone extends VacationRequestState {
  const VacationRequestDone(
    List<VacationRequestEntity>? vacationRequest,
    List<SettingsEntity>? settingRequests,
  ) : super(
          vacationRequest: vacationRequest,
          settingRequests: settingRequests,
        );
}

class VacationRequestError extends VacationRequestState {
  const VacationRequestError(
    DioException error,
  ) : super(
          error: error,
        );
}
