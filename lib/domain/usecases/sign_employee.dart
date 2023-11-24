import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/domain/repository/authentication_repository.dart';
import 'package:flutter_application_gustov/domain/repository/employee_repository.dart';
import 'package:flutter_application_gustov/domain/repository/session_repository.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class SignEmployeeUseCase
    implements UseCase<DataState<EmployeeEntity>, SignEmployeeParams> {
  final AuthenticationRepository _auth;
  final EmployeeRepository _user;
  final SessionRepository _session;
  SignEmployeeUseCase(
    this._auth,
    this._user,
    this._session,
  );
  @override
  Future<DataState<EmployeeEntity>> call({SignEmployeeParams? params}) async {
    final user =
        await _auth.signInWithEmailAndPassword(params!.email, params.password);
    if (user is DataEmpty) return const DataEmpty();

    final member = await _user.getByType("uid", user.data!.uid);
    if (member is DataEmpty) return const DataEmpty();
    await _session.saveToSession(member.data!);
    return member;
  }
}

class SignEmployeeParams {
  SignEmployeeParams(this.email, this.password);
  final String email;
  final String password;
}
