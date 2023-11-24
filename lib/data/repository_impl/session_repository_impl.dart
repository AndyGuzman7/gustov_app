import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/repository/employee_repository.dart';
import 'package:flutter_application_gustov/domain/repository/session_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepositoryImpl extends SessionRepository {
  final EmployeeRepository _userRepository;

  SessionRepositoryImpl(this._userRepository);

  @override
  Future<DataState<void>> saveToSession(EmployeeEntity user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id!);
    return const DataSuccess(null);
  }

  @override
  Future<DataState<void>> removeToSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    return const DataSuccess(null);
  }

  @override
  Future<DataState<EmployeeEntity?>> getToSession() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');
    if (id == null) return const DataEmpty();
    final user = await _userRepository.getEmployeeById(id);
    return user;
  }
}
