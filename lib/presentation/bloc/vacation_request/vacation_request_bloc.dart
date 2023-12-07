import 'package:bloc/bloc.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/usecases/get_scale_days_vacation.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_state.dart';

import '../../../domain/usecases/get_vacation_request.dart';

class VacationRequestBloc
    extends Bloc<VacationRequestEvent, VacationRequestState> {
  VacationRequestBloc(
    this._getVacationRequest,
    this._getScaleDaysVacationUseCase,
  ) : super(const VacationRequestLoading()) {
    on<GetVacationRequest>(onGetVacationRequest);
  }
  final GetScaleDaysVacationUseCase _getScaleDaysVacationUseCase;
  final GetVacationRequestUseCase _getVacationRequest;

  Future<void> onGetVacationRequest(
    GetVacationRequest event,
    Emitter<VacationRequestState> emit,
  ) async {
    final dataState = await _getVacationRequest.call();
    final scaleVactionDay = await _getScaleDaysVacationUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(VacationRequestDone(dataState.data!, scaleVactionDay.data!));
    }

    if (dataState is DataFailed) {
      emit(VacationRequestError(dataState.error!));
    }
  }
}
