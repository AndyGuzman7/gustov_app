import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class GetVacationRequestByEmployeeUseCase
    implements UseCase<DataState<List<VacationRequestEntity>>, String> {
  final VacationRequestRepository _vacationRequestRepository;

  GetVacationRequestByEmployeeUseCase(this._vacationRequestRepository);
  @override
  Future<DataState<List<VacationRequestEntity>>> call({String? params}) {
    return _vacationRequestRepository.getVacationRequestBydId(params!);
  }
}

class GetVacationRequestByEmployeeParams {
  GetVacationRequestByEmployeeParams(this.id);
  final String id;
}
