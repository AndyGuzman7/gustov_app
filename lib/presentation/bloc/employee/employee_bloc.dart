import 'package:bloc/bloc.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/usecases/get_employees.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc(
    this._getEmployeesUseCase,
  ) : super(const EmployeeLoading()) {
    on<GetEmployees>(onGetEmployeeRequest);
    on<InitEvent>(onInit);
  }

  final GetEmployeesUseCase _getEmployeesUseCase;

  Future<void> onGetEmployeeRequest(
    GetEmployees event,
    Emitter<EmployeeState> emit,
  ) async {
    final dataState = await _getEmployeesUseCase.call();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(EmployeeDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(EmployeeError(dataState.error!));
    }
  }

  Future<void> onInit(
    InitEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    final dataState = await _getEmployeesUseCase.call();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(EmployeeDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(EmployeeError(dataState.error!));
    }
  }
}
