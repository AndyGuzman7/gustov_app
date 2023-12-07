import 'package:flutter/cupertino.dart';

abstract class VacationRequestCreateEvent {
  const VacationRequestCreateEvent();
}

class StartedVacationRequestCreateEvent implements VacationRequestCreateEvent {
  const StartedVacationRequestCreateEvent();
}

class DescriptionChangedRegisterEvent implements VacationRequestCreateEvent {
  final String description;
  const DescriptionChangedRegisterEvent(this.description);
}

class DateSelectedChangedRegisterEvent implements VacationRequestCreateEvent {
  final DateTime dateSelected;
  const DateSelectedChangedRegisterEvent(this.dateSelected);
}

class CleanDialogChangedRegisterEvent implements VacationRequestCreateEvent {
  const CleanDialogChangedRegisterEvent();
}

class RegisterVacationSubmittedRegisterEvent
    implements VacationRequestCreateEvent {
  final BuildContext context;
  const RegisterVacationSubmittedRegisterEvent(this.context);
}
