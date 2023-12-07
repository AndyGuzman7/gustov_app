import 'package:flutter_application_gustov/data/data_sources/remote/dao.database_firestore/base_remote_data_soruce.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.interfaces/dao_employee.dart';
import 'package:flutter_application_gustov/data/models/employee_model.dart';

class DAOEmployeeImpl extends BaseFirestoreRepositoryImpl<EmployeeModel>
    implements DAOEmployee {
  DAOEmployeeImpl() : super("users");

  @override
  EmployeeModel fromJson(Map<String, dynamic> map) {
    return EmployeeModel.fromJson(map);
  }

  @override
  Map<String, dynamic> toJson(EmployeeModel t) {
    return t.toJson();
  }
}
