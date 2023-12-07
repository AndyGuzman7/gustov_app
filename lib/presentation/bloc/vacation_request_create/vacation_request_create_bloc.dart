import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/routes/routes.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/data/models/error_dialog_data.dart';
import 'package:flutter_application_gustov/data/models/vacation_request_model.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/domain/usecases/get_scale_days_vacation.dart';
import 'package:flutter_application_gustov/domain/usecases/get_vacation_request_by_employee.dart';
import 'package:flutter_application_gustov/domain/usecases/insert_vacation_request.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/dialogs/dialogs.dart';
import 'package:flutter_application_gustov/presentation/widgets/loading/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VacationRequestCreateBloc
    extends Bloc<VacationRequestCreateEvent, VacationRequestCreateState> {
  final SessionBloc sessionBloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GetVacationRequestByEmployeeUseCase
      _getVacationRequestByEmployeeUseCase;
  final InsertVacationRequestUseCase _insertVacationRequestUseCase;
  final GetScaleDaysVacationUseCase _getScaleDaysVacationUseCase;

  VacationRequestCreateBloc(
    this.sessionBloc,
    this._getVacationRequestByEmployeeUseCase,
    this._insertVacationRequestUseCase,
    this._getScaleDaysVacationUseCase,
  ) : super(const VacationRequestCreateState()) {
    on<StartedVacationRequestCreateEvent>(
      (event, emit) => _started(event, emit),
    );
    on<DescriptionChangedRegisterEvent>(
      (event, emit) => _onChangedDescription(event, emit),
    );

    on<RegisterVacationSubmittedRegisterEvent>(
        (event, emit) => _onRegisterSubmitted(event, emit));

    on<DateSelectedChangedRegisterEvent>(
        (event, emit) => _onChangedDateSelected(event, emit));
    on<CleanDialogChangedRegisterEvent>(
        (event, emit) => _onChangedCleanDialog(event, emit));
  }

  Future<void> _started(
    StartedVacationRequestCreateEvent event,
    Emitter<VacationRequestCreateState> emit,
  ) async {
    final user = sessionBloc.state.user!.id;
    final list = await _getVacationRequestByEmployeeUseCase(params: user);

    final scaleVactionDay = await _getScaleDaysVacationUseCase();

    emit(
      state.copyWith(
        vacationRequest: list.data,
        settingRequests: scaleVactionDay.data,
      ),
    );
  }

  void _onChangedDescription(
    DescriptionChangedRegisterEvent event,
    Emitter<VacationRequestCreateState> emit,
  ) {
    emit(
      state.copyWith(
        description: event.description,
      ),
    );
  }

  void _onChangedCleanDialog(
    CleanDialogChangedRegisterEvent event,
    Emitter<VacationRequestCreateState> emit,
  ) {
    emit(
      state.cleanDialog(),
    );
  }

  void _onChangedDateSelected(
    DateSelectedChangedRegisterEvent event,
    Emitter<VacationRequestCreateState> emit,
  ) {
    emit(
      state.copyWith(
        dateSelected: event.dateSelected,
      ),
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterVacationSubmittedRegisterEvent event,
    Emitter<VacationRequestCreateState> emit,
  ) async {
    final BuildContext buildContext = event.context;
    if (!isFormValid()) return;

    Loading.showText(buildContext, "Solicitando");
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
    RegisterVacationSubmittedRegisterEvent event,
    Emitter<VacationRequestCreateState> emit,
  ) async {
    Dialogs.showErrorMessage(
      buildContext,
      ErrorDialogData(
        "No se hizo la solicitud",
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

  Future<VacationRequestEntity?> _submit() async {
    VacationRequestModel employee = VacationRequestModel(
      id: '',
      description: state.description!,
      idEmployee: sessionBloc.state.user!.id,
      autorization: 0,
      dateRequest: DateTime.now(),
      dateVacationInit: state.dateSelected,
    );

    final response = await _insertVacationRequestUseCase(
      params: InsertVacationRequestParams(employee),
    );
    if (response is DataSuccess<VacationRequestEntity>) {
      return response.data;
    }
    return null;
  }

  bool isFormValid() {
    final isEnableForm = formKey.currentState;
    return isEnableForm != null && formKey.currentState!.validate();
  }
}
