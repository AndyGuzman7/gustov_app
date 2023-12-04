import 'package:flutter_application_gustov/data/data_sources/remote/dao.interfaces/dao_vacation_request.dart';
import 'package:flutter_application_gustov/data/models/vacation_request_model.dart';

import '../dao.database_firestore/base_remote_data_soruce.dart';

class DAOVacationRequestImpl
    extends BaseFirestoreRepositoryImpl<VacationRequestModel>
    implements DAOVactionRequest {
  DAOVacationRequestImpl() : super("VacationRequest");

  @override
  VacationRequestModel fromJson(Map<String, dynamic> map) {
    return VacationRequestModel.fromJson(map);
  }

  @override
  Map<String, dynamic> toJson(VacationRequestModel t) {
    return t.toJson();
  }
}
