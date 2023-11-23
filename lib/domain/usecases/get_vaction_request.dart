import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class GetVacationRequest
    implements UseCase<DataState<List<VacationRequestEntity>>, void> {
  final VacationRequestRepository _vacationRequestRepository;

  GetVacationRequest(this._vacationRequestRepository);
  @override
  Future<DataState<List<VacationRequestEntity>>> call({void params}) {
    return _vacationRequestRepository.getVacationRequest();
  }
}
