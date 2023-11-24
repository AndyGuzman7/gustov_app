import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/routes/routes.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/data/models/error_dialog_data.dart';
import 'package:flutter_application_gustov/data/models/vacation_request_model.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
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
  VacationRequestCreateBloc(
    this.sessionBloc,
    this._getVacationRequestByEmployeeUseCase,
    this._insertVacationRequestUseCase,
  ) : super(const VacationRequestCreateState()) {
    on<StartedVacationRequestCreateEvent>(
      (event, emit) => _started(event, emit),
    );
    on<DescriptionChangedRegisterEvent>(
      (event, emit) => _onChangedName(event, emit),
    );

    on<RegisterVacationSubmittedRegisterEvent>(
        (event, emit) => _onRegisterSubmitted(event, emit));
    //add(StartedVacationRequestCreateEvent())
  }

  Future<void> _started(
    StartedVacationRequestCreateEvent event,
    Emitter<VacationRequestCreateState> emit,
  ) async {
    print("hola");
    final user = sessionBloc.state.user!.id;
    final list = await _getVacationRequestByEmployeeUseCase(params: user);
    if (list is DataEmpty<List<VacationRequestEntity>>) return;
    print(list.data!.length.toString());
    emit(
      state.copyWith(
        vacationRequest: list.data,
      ),
    );
    print("asfjkksjdjkasd");
  }

  void _onChangedName(
    DescriptionChangedRegisterEvent event,
    Emitter<VacationRequestCreateState> emit,
  ) {
    emit(
      state.copyWith(
        description: event.description,
      ),
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterVacationSubmittedRegisterEvent event,
    Emitter<VacationRequestCreateState> emit,
  ) async {
    print("holaas");
    // if (!event. context.) return;
    final BuildContext buildContext = event.context;
    if (!isFormValid()) return;
    //FocusScope.of(buildContext).unfocus();
    Loading.showText(buildContext, "Solictando");
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

  _closeForm(BuildContext context) {
    Navigator.pop(context);
  }

  String generarIdUnico() {
    final now = DateTime.now();
    final formattedDate = "${now.year}${now.month}${now.day}";
    final random = Random();
    final letrasAleatorias = String.fromCharCodes(List.generate(4,
        (index) => random.nextInt(26) + 65)); // Genera letras aleatorias (A-Z).

    final idUnico = "$formattedDate$letrasAleatorias";

    return idUnico;
  }

  Future<VacationRequestEntity?> _submit() async {
    VacationRequestModel employee = VacationRequestModel(
      id: '',
      description: state.description!,
      idEmployee: sessionBloc.state.user!.id,
      autorization: 0,
      dateRequest: DateTime.now(),
    );
    print(employee.idEmployee);
    print("super");
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
