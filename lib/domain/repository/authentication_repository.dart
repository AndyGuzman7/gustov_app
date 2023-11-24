import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

abstract class AuthenticationRepository {
  Future<void> signOut();
  Future<DataState<EmployeeEntity?>> signInWithCode(String code);
  Future<DataState<User?>> signInWithEmailAndPassword(
      String email, String password);
  Future<DataState<User?>> createUserWithEmailAndPassword(
      String email, String password);
}
