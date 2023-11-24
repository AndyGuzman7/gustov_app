import 'package:dio/dio.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.interfaces/dao_employee.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.interfaces/dao_vacation_request.dart';
import 'package:flutter_application_gustov/data/models/employee_model.dart';
import 'package:flutter_application_gustov/data/models/vacation_request_model.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/repository/session_repository.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class VacationRequestRepositoryImpl implements VacationRequestRepository {
  final DAOVacationRequest _daoVacationRequest;
  final DAOEmployee _daoEmployee;

  VacationRequestRepositoryImpl(
    this._daoVacationRequest,
    this._daoEmployee,
  );

  @override
  Future<DataState<List<VacationRequestEntity>>> getVacationRequest() async {
    try {
      final list = await _daoVacationRequest.getAll();
      final user = await _daoEmployee.getAll();
      final listNew = convertListModelsToEntities(list, user);

      return DataSuccess(listNew);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<VacationRequestEntity>>> getVacationRequestBydId(
      String idUser) async {
    try {
      final list = await _daoVacationRequest.getAllByType('idEmployee', idUser);
      final user = await _daoEmployee.getAll();
      final listNew = convertListModelsToEntities(list, user);
      return DataSuccess(listNew);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<VacationRequestEntity>> insertVacationRequestBydId(
      VacationRequestModel vac) async {
    try {
      final list = await _daoVacationRequest.insertWithGeneratedId(vac);
      final user = await _daoEmployee.getById(vac.idEmployee!);

      if (list) {
        return DataSuccess(VacationRequestEntity.fromModel(vac, user!));
      }
      return const DataEmpty();
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  List<VacationRequestEntity> convertListModelsToEntities(
    List<VacationRequestModel> list,
    List<EmployeeModel> user,
  ) {
    final newList = list
        .map(
          (e) => VacationRequestEntity.fromModel(
            e,
            user.firstWhere((element) => element.id == e.idEmployee),
          ),
        )
        .toList();
    return newList;
  }
}
