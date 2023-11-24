import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionState()) {
    on<StartedSessionEvent>((event, emit) => _started(event, emit));
    on<ChangeSessionSessionEvent>((event, emit) => _changeSession(event, emit));
  }

  void _started(StartedSessionEvent event, Emitter<SessionState> emit) {}

  void _changeSession(
    ChangeSessionSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  void setUser(EmployeeEntity userData) {
    add(ChangeSessionSessionEvent(userData));
  }

  void removerUser() {
    add(const ChangeSessionSessionEvent(null));
  }
}
