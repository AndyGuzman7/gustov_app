import 'package:equatable/equatable.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_gustov/core/services/email_service.dart';
import 'package:flutter_application_gustov/core/services/pdf_service.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/resources/content_pdf_formater.dart';

import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/domain/usecases/change_status_vacation.dart';
import 'package:flutter_application_gustov/presentation/widgets/dialogs/dialogs.dart';
import 'package:flutter_application_gustov/presentation/widgets/loading/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/error_dialog_data.dart';
import '../../../domain/entities/settings_entity.dart';
part 'dialog_event.dart';
part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  DialogBloc(this._changeStatusVacationUseCase) : super(const DialogLoading()) {
    on<InitDialogEvent>(onInit);
    on<AcceptVacationDialogEvent>(onAcceptVacation);
    on<DenegatedVacationDialogEvent>(onDenegatedVacation);
  }

  final ChangeStatusVacationUseCase _changeStatusVacationUseCase;

  Future<void> onInit(
    InitDialogEvent event,
    Emitter<DialogState> emit,
  ) async {
    emit(DialogDone(event.vacationRequest, event.settingRequests));
  }

  Future<void> onAcceptVacation(
    AcceptVacationDialogEvent event,
    Emitter<DialogState> emit,
  ) async {
    Loading.showText(event.context, "Enviando...");
    final response = await _changeStatusVacationUseCase(
        params:
            ChangeStatusVacationUseCaseParams(state.vacationRequest!.id!, 1));
    if (response is DataSuccess<bool>) {
      await sendChanged(true);
    }
    Loading.close();

    if (response.data!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(event.context).pop();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorMessage(event.context, event, emit);
      });
    }
  }

  Future sendChanged(bool authorization) async {
    try {
      final employeeEntity = state.vacationRequest!.employeeEntity!;
      final font = await PdfService.getFont();
      final content = ContentPdfFormater(font);
      final pdfFile = await PdfService.createPdf(
        content: content.buildContent(
          name: employeeEntity.name!,
          email: employeeEntity.email!,
          dateStart: state.vacationRequest!.dateVacationInit!,
          description: state.vacationRequest!.description!,
          listScale: state.settingRequests!,
          dateStartWorking: employeeEntity.workStartDate!,
          authorization: authorization,
        ),
      );
      await EmailService.sendEmailWithPdf(
        emailClient: employeeEntity.email!,
        subJect: "Recibo de vacaciones",
        text: "Recibo",
        attachment: pdfFile,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> showErrorMessage(
    BuildContext buildContext,
    dynamic event,
    Emitter<DialogState> emit,
  ) async {
    Dialogs.showErrorMessage(
      buildContext,
      ErrorDialogData(
        "No se pudo enviar",
        "Envio Fallido",
        "Reintentar",
        () async {
          Dialogs.close();
          await onAcceptVacation(event, emit); // Llamada al mismo método
        },
        false,
      ),
    );
  }

  Future<void> onDenegatedVacation(
    DenegatedVacationDialogEvent event,
    Emitter<DialogState> emit,
  ) async {
    Loading.showText(event.context, "Cancelando...");
    final response = await _changeStatusVacationUseCase(
        params:
            ChangeStatusVacationUseCaseParams(state.vacationRequest!.id!, -1));
    if (response is DataSuccess<bool>) {
      await sendChanged(false);
    }
    Loading.close();

    if (response.data!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(event.context).pop();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorMessage(event.context, event, emit);
      });
    }
  }
}
