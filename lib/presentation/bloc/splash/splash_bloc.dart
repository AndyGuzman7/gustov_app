import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/routes/routes.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/usecases/get_session.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_bloc.dart';
import 'package:get/get.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetSessionUseCase _getSessionUseCase;
  final SessionBloc sessionBloc;
  SplashBloc(this.sessionBloc, this._getSessionUseCase)
      : super(SplashState.initialState) {
    on<ChangeRoute>(onChangeRoute);
    on<InitialEvent>(initialEvent);
    add(InitialEvent());
  }

  Future<void> initialEvent(
      InitialEvent event, Emitter<SplashState> emit) async {
    String routeName;

    final user = await _getSessionUseCase();

    if (user is DataEmpty) {
      routeName = Routes.login;
    } else {
      routeName = Routes.home;
      sessionBloc.setUser(user.data!);
    }
    add(ChangeRoute(routeName));
  }

  void onChangeRoute(ChangeRoute event, Emitter<SplashState> emit) {
    emit(state.copyWith(route: event.route));
  }
}
