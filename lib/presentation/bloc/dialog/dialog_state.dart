part of 'dialog_bloc.dart';

class DialogState extends Equatable {
  final VacationRequestEntity? vacationRequest;
  final DioException? error;
  final List<SettingsEntity>? settingRequests;
  const DialogState({
    this.vacationRequest,
    this.error,
    this.settingRequests,
  });
  DialogState copyWith({
    final DioException? error,
    VacationRequestEntity? vacationRequest,
    List<SettingsEntity>? settingRequests,
  }) {
    return DialogState(
      error: error ?? this.error,
      vacationRequest: vacationRequest ?? this.vacationRequest,
      settingRequests: settingRequests ?? this.settingRequests,
    );
  }

  @override
  List<Object?> get props => [vacationRequest!, error!];
}

class DialogLoading extends DialogState {
  const DialogLoading();
}

class DialogDone extends DialogState {
  const DialogDone(
    VacationRequestEntity? vacationRequest,
    List<SettingsEntity>? settingRequests,
  ) : super(
          vacationRequest: vacationRequest,
          settingRequests: settingRequests,
        );
}

class DialogError extends DialogState {
  const DialogError(
    DioException error,
  ) : super(
          error: error,
        );
}
