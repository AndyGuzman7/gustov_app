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

class RegisterVacationSubmittedRegisterEvent
    implements VacationRequestCreateEvent {
  final BuildContext context;
  const RegisterVacationSubmittedRegisterEvent(this.context);
}
