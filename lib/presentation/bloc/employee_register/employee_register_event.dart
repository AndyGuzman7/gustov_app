import 'package:flutter/cupertino.dart';

abstract class EmployeeRegisterEvent {
  const EmployeeRegisterEvent();
}

class StartedRegisterEvent implements EmployeeRegisterEvent {
  const StartedRegisterEvent();
}

class NameChangedRegisterEvent implements EmployeeRegisterEvent {
  final String name;
  const NameChangedRegisterEvent(this.name);
}

class LastNameChangedRegisterEvent implements EmployeeRegisterEvent {
  final String lastName;
  const LastNameChangedRegisterEvent(this.lastName);
}

class LastNameSecondChangedRegisterEvent implements EmployeeRegisterEvent {
  final String lastNameSecond;
  const LastNameSecondChangedRegisterEvent(this.lastNameSecond);
}

class EmailChangedRegisterEvent implements EmployeeRegisterEvent {
  final String email;
  const EmailChangedRegisterEvent(this.email);
}

class RegisterSubmittedRegisterEvent implements EmployeeRegisterEvent {
  final BuildContext context;
  const RegisterSubmittedRegisterEvent(this.context);
}
