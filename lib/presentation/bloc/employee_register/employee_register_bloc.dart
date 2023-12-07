import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/services/email_service.dart';
import 'package:flutter_application_gustov/data/models/employee_model.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/usecases/insert_employee.dart';
import 'package:flutter_application_gustov/domain/usecases/signup_employee.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee_register/employee_register_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee_register/employee_register_state.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_bloc.dart';
import 'package:flutter_application_gustov/presentation/widgets/dialogs/dialogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.dart';
import '../../../data/models/error_dialog_data.dart';
import '../../../domain/repository/session_repository.dart';
import '../../widgets/loading/loading.dart';

class EmployeeRegisterBloc
    extends Bloc<EmployeeRegisterEvent, EmployeeRegisterState> {
  final SessionBloc sessionBloc;
  final SignUpEmployeeUseCase _signUpEmployeeUseCase;
  /*final UserRepository userRepository;*/
  final InsertEmployeeUseCase _insertEmployeeUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SessionRepository session;

  EmployeeRegisterBloc(
    this.sessionBloc,
    this._insertEmployeeUseCase,
    this.session,
    this._signUpEmployeeUseCase,
  ) : super(const EmployeeRegisterState()) {
    on<StartedRegisterEvent>((event, emit) => _started());
    on<NameChangedRegisterEvent>(
      (event, emit) => _onChangedName(event, emit),
    );
    on<LastNameChangedRegisterEvent>(
      (event, emit) => _onChangedLastName(event, emit),
    );
    on<LastNameSecondChangedRegisterEvent>(
      (event, emit) => _onChangedLastNameSecond(event, emit),
    );

    on<RegisterSubmittedRegisterEvent>((event, emit) {
      _onRegisterSubmitted(event, emit);
    });
    on<EmailChangedRegisterEvent>(
        (event, emit) => _onChangedEmail(event, emit));
  }

  void _started() {}

  void _onChangedName(
    NameChangedRegisterEvent event,
    Emitter<EmployeeRegisterState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.name,
      ),
    );
  }

  void _onChangedLastName(
    LastNameChangedRegisterEvent event,
    Emitter<EmployeeRegisterState> emit,
  ) {
    emit(
      state.copyWith(
        lastName: event.lastName,
      ),
    );
  }

  void _onChangedEmail(
    EmailChangedRegisterEvent event,
    Emitter<EmployeeRegisterState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onChangedLastNameSecond(
    LastNameSecondChangedRegisterEvent event,
    Emitter<EmployeeRegisterState> emit,
  ) {
    emit(state.copyWith(
      lastNameSecond: event.lastNameSecond,
    ));
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmittedRegisterEvent event,
    Emitter<EmployeeRegisterState> emit,
  ) async {
    // if (!event. context.) return;
    final BuildContext buildContext = event.context;
    if (!isFormValid()) return;
    //FocusScope.of(buildContext).unfocus();
    Loading.showText(buildContext, "Registrando");
    final response = await _submit();
    Loading.close();
    if (response != null) {
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

  Future<void> showErrorMessage(
    BuildContext buildContext,
    RegisterSubmittedRegisterEvent event,
    Emitter<EmployeeRegisterState> emit,
  ) async {
    Dialogs.showErrorMessage(
      buildContext,
      ErrorDialogData(
        "No se registro un nuevo usuario",
        "Registro Fallido",
        "Reintentar",
        () async {
          Dialogs.close();
          await _onRegisterSubmitted(event, emit); // Llamada al mismo método
        },
        false,
      ),
    );
  }

  Future<EmployeeEntity?> _submit() async {
    final password = generatePassword();

    final user = await _signUpEmployeeUseCase(
      params: SignUpEmployeeParams(state.email!, password),
    );

    if (user is DataEmpty<User>) return null;

    EmployeeModel employee = EmployeeModel(
      id: '',
      name: state.name!,
      lastName: state.lastName!,
      secondLastName: state.lastNameSecond!,
      email: state.email!,
      password: password,
      position: 'Employee',
      uid: user.data!.uid,
      workStartDate: DateTime.now(),
    );

    final response =
        await _insertEmployeeUseCase(params: InsertEmployeeParams(employee));
    if (response is DataSuccess<EmployeeEntity>) {
      await EmailService.sendEmail(
          employee.email!,
          "Contraseña del sistema de Gustov APP",
          "Contraseña: ${employee.password}");
      return response.data;
    }
    return null;
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }

  String generatePassword() {
    const String charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

    final Random random = Random();
    const int length = 8;

    String password = '';
    Set<int> usedIndices = {};

    for (int i = 0; i < length; i++) {
      int randomIndex;

      // Asegurarse de que el índice no se haya utilizado antes
      do {
        randomIndex = random.nextInt(charset.length);
      } while (usedIndices.contains(randomIndex));

      password += charset[randomIndex];
      usedIndices.add(randomIndex);
    }

    return password;
  }
}
