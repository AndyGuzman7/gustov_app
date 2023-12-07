import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class ChangeStatusVacationUseCase
    implements UseCase<DataState<bool>, ChangeStatusVacationUseCaseParams> {
  final VacationRequestRepository _vacationRequestRepository;

  ChangeStatusVacationUseCase(this._vacationRequestRepository);
  @override
  Future<DataState<bool>> call(
      {ChangeStatusVacationUseCaseParams? params}) async {
    return await _vacationRequestRepository.changeAuthorizationVacation(
        params!.status, params.id);
  }
}

class ChangeStatusVacationUseCaseParams {
  ChangeStatusVacationUseCaseParams(this.id, this.status);
  final String id;
  final int status;
}
