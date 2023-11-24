import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();
}

class StartedSessionEvent extends SessionEvent {
  const StartedSessionEvent() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChangeSessionSessionEvent extends SessionEvent {
  final EmployeeEntity? user;
  const ChangeSessionSessionEvent(this.user) : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}
