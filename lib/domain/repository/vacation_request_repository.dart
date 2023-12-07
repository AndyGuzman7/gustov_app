import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/data/models/vacation_request_model.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

abstract class VacationRequestRepository {
  Future<DataState<List<VacationRequestEntity>>> getVacationRequest();

  Future<DataState<List<VacationRequestEntity>>> getVacationRequestBydId(
      String idUser);

  Future<DataState<VacationRequestEntity>> insertVacationRequestBydId(
      VacationRequestModel vac);

  Future<DataState<bool>> changeAuthorizationVacation(int status, String id);
}
