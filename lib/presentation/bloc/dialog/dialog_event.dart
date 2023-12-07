part of 'dialog_bloc.dart';

abstract class DialogEvent {
  const DialogEvent();
}

class InitDialogEvent extends DialogEvent {
  final VacationRequestEntity? vacationRequest;
  final List<SettingsEntity>? settingRequests;
  const InitDialogEvent(this.vacationRequest, this.settingRequests);
}

class AcceptVacationDialogEvent extends DialogEvent {
  final BuildContext context;
  const AcceptVacationDialogEvent(this.context);
}

class DenegatedVacationDialogEvent extends DialogEvent {
  final BuildContext context;
  const DenegatedVacationDialogEvent(this.context);
}
