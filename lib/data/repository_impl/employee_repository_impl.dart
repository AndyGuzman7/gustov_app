import 'package:dio/dio.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.interfaces/dao_employee.dart';
import 'package:flutter_application_gustov/data/models/employee_model.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/repository/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final DAOEmployee _daoEmployee;

  EmployeeRepositoryImpl(this._daoEmployee);

  @override
  Future<DataState<List<EmployeeModel>>> getEmployees() async {
    try {
      final list = await _daoEmployee.getAll();
      return DataSuccess(list);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<EmployeeModel>> getEmployeeById(String id) async {
    try {
      final response = await _daoEmployee.getById(id);
      if (response == null) return const DataEmpty();
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<EmployeeModel>> getByType(String field, String type) async {
    /* try {*/
    final response = await _daoEmployee.getByType(field, type);
    print("model");
    print(response);
    if (response == null) return const DataEmpty();
    return DataSuccess(response);
    /*} on DioException catch (e) {
      return DataFailed(e);
    }*/
  }

  @override
  Future<DataState<EmployeeEntity>> insert(EmployeeModel employeeModel) async {
    final response = await _daoEmployee.insertWithGeneratedId(employeeModel);
    print("model");
    print(response);
    if (response == null) return const DataEmpty();
    return DataSuccess(employeeModel);
  }
}
