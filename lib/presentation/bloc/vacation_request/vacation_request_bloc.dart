import 'package:bloc/bloc.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_state.dart';

import '../../../domain/usecases/get_vaction_request.dart';

class VacationRequestBloc
    extends Bloc<VacationRequestEvent, VacationRequestState> {
  VacationRequestBloc(
    this._getVacationRequest,
  ) : super(const VacationRequestLoading()) {
    on<VacationRequestEvent>(onGetVacationRequest);
  }

  final GetVacationRequestUseCase _getVacationRequest;

  Future<void> onGetVacationRequest(
    VacationRequestEvent event,
    Emitter<VacationRequestState> emit,
  ) async {
    final dataState = await _getVacationRequest.call();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(VacationRequestDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(VacationRequestError(dataState.error!));
    }
  }
}
