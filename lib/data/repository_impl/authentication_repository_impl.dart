import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.database_firestore/firebase_service.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  //final UserRepository _userRepository = Get.find<UserRepository>();

  final FirebaseAuth _firebaseAuth;

  AuthenticationRepositoryImpl()
      : _firebaseAuth = FirebaseInstance().firebaseAuth;

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<DataState<EmployeeEntity?>> signInWithCode(String code) async {
    try {
      /*final user = await _userRepository.getByType("code", code);
      return user;*/
    } catch (e) {
      return const DataEmpty();
    }
    return const DataEmpty();
  }

  @override
  Future<DataState<User?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user == null) return const DataEmpty();

      print("siuuddd");
      return DataSuccess(user);
    } catch (e) {
      print("sdfsadfasfasf");
      log(e.toString());
      return const DataEmpty();
    }
  }

  @override
  Future<DataState<User?>> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      return DataSuccess(user);
    } catch (e) {
      print('Error creating user: $e');
      return const DataEmpty();
    }
  }
}
