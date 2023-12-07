import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/routes/routes.dart';
import 'package:flutter_application_gustov/config/util/input_validators.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/data/models/error_dialog_data.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/usecases/save_session.dart';
import 'package:flutter_application_gustov/domain/usecases/sign_employee.dart';
import 'package:flutter_application_gustov/presentation/bloc/login/login_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/login/login_state.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_bloc.dart';
import 'package:flutter_application_gustov/presentation/widgets/dialogs/dialogs.dart';
import 'package:flutter_application_gustov/presentation/widgets/loading/loading.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionBloc sessionBloc;

  final SaveSessionUseCase _saveSessionUseCase;
  final SignEmployeeUseCase _signEmployeeUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginBloc(
    this.sessionBloc,
    this._saveSessionUseCase,
    this._signEmployeeUseCase,
  ) : super(const LoginState()) {
    on<EmailChangedLoginEvent>((event, emit) => _onEmailChanged(event, emit));
    on<PasswordChangedLoginEvent>(
        (event, emit) => _onPasswordChanged(event, emit));
    on<LoginSubmittedLoginEvent>((event, emit) {
      _onLoginSubmitted(event, emit);
    });
  }

  void _onEmailChanged(
    EmailChangedLoginEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      email: event.emailString,
    ));
  }

  void _onPasswordChanged(
    PasswordChangedLoginEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      password: event.passwordString,
    ));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final BuildContext buildContext = event.context;

      final email = state.email;
      final password = state.password;

      if (!isFormValid()) {
        return;
      }

      Loading.showText(buildContext, "Iniciando Sesión...");

      final response = await _submit(password!, email!);

      Loading.close();

      if (response != null) {
        setUserInSession(response);
        await _saveSessionUseCase(params: SaveSessionParams(response));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Navigator.canPop(buildContext)) {
            Navigator.pushReplacementNamed(buildContext, Routes.home);
          }
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showErrorMessage(buildContext, event, emit);
        });
      }
    } catch (e) {}
  }

  Future<void> showErrorMessage(
    BuildContext buildContext,
    LoginSubmittedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    Dialogs.showErrorMessage(
      buildContext,
      ErrorDialogData(
        "Ocurrió un problema al iniciar sesión, puede que no tenga una cuenta.",
        "Error",
        "Reintentar",
        () async {
          Dialogs.close();
          await _onLoginSubmitted(event, emit);
        },
        false,
      ),
    );
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }

  void setUserInSession(EmployeeEntity response) {
    sessionBloc.setUser(response);
  }

  void navigateToHome(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.canPop(context)) {
        Future.microtask(() {
          Navigator.pushReplacementNamed(context, Routes.home);
        });
      }
    });
  }

  Future<EmployeeEntity?> _submit(
    String password,
    String email,
  ) async {
    final response =
        await _signEmployeeUseCase(params: SignEmployeeParams(email, password));

    if (response is DataSuccess) {
      return response.data;
    } else if (response is DataFailed) {
      print(response.error!.error);
    }
    return null;
  }

  String? Function(String?) get validationEmail => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
        }
        if (!InputValidators.isEmail(value)) {
          return "Email Invalido";
        }

        return null;
      };
  String? Function(String?) get validationPassword => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
        }

        return null;
      };
}
