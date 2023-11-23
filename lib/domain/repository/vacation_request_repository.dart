import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

abstract class VacationRequestRepository {
  Future<DataState<List<VacationRequestEntity>>> getVacationRequest();
}
