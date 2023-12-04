import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

abstract class VacationRequestState extends Equatable {
  final List<VactionRequestEntity>? vacationRequest;
  final DioException? error;

  const VacationRequestState({this.vacationRequest, this.error});

  @override
  List<Object?> get props => [vacationRequest!, error!];
}

class VacationRequestLoading extends VacationRequestState {
  const VacationRequestLoading();
}

class VacationRequestDone extends VacationRequestState {
  const VacationRequestDone(
    List<VactionRequestEntity>? vacationRequest,
  ) : super(
          vacationRequest: vacationRequest,
        );
}

class VacationRequestError extends VacationRequestState {
  const VacationRequestError(
    DioException error,
  ) : super(
          error: error,
        );
}
