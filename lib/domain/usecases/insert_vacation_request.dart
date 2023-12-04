import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/data/models/vacation_request_model.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class InsertVacationRequestUseCase
    implements
        UseCase<DataState<VactionRequestEntity>, InsertVacationRequestParams> {
  final VacationRequestRepository _vacationRequestRepository;

  InsertVacationRequestUseCase(this._vacationRequestRepository);
  @override
  Future<DataState<VactionRequestEntity>> call(
      {InsertVacationRequestParams? params}) async {
    return await _vacationRequestRepository
        .insertVacationRequestBydId(params!.vacationRequestEntity);
  }
}

class InsertVacationRequestParams {
  InsertVacationRequestParams(this.vacationRequestEntity);
  final VacationRequestModel vacationRequestEntity;
}
