import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

class SessionState {
  final EmployeeEntity? user;

  SessionState({
    this.user,
  });

  SessionState copyWith({
    EmployeeEntity? user,
  }) {
    return SessionState(
      user: user ?? this.user,
    );
  }
}
