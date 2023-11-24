import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/domain/repository/authentication_repository.dart';
import 'package:flutter_application_gustov/domain/repository/employee_repository.dart';
import 'package:flutter_application_gustov/domain/repository/session_repository.dart';
import 'package:flutter_application_gustov/domain/repository/vacation_request_repository.dart';

class SignUpEmployeeUseCase
    implements UseCase<DataState<User?>, SignUpEmployeeParams> {
  final AuthenticationRepository _auth;

  SignUpEmployeeUseCase(
    this._auth,
  );
  @override
  Future<DataState<User?>> call({SignUpEmployeeParams? params}) async {
    final user = await _auth.createUserWithEmailAndPassword(
        params!.email, params.password);

    if (user is DataEmpty<User>) return const DataEmpty();
    return user;
  }
}

class SignUpEmployeeParams {
  SignUpEmployeeParams(this.email, this.password);
  final String email;
  final String password;
}
