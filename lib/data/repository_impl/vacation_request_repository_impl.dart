import 'package:dio/dio.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.interfaces/dao_vacation_request.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class VacationRequestRepositoryImpl implements VacationRequestRepository {
  final DAOVacationRequest _daoVacationRequest;

  VacationRequestRepositoryImpl(this._daoVacationRequest);

  @override
  Future<DataState<List<VacationRequestEntity>>> getVacationRequest() async {
    try {
      final list = await _daoVacationRequest.getAll();
      return DataSuccess(list);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
