import 'package:flutter_application_gustov/data/data_sources/remote/dao.database_firestore/base_remote_data_soruce.dart';
import 'package:flutter_application_gustov/data/models/vacation_request_model.dart';

abstract class DAOVacationRequest
    extends BaseFirestoreRepository<VacationRequestModel> {}
