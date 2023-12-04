import 'package:flutter_application_gustov/data/data_sources/remote/dao.database_firestore/base_remote_data_soruce.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.interfaces/dao_settings.dart';
import 'package:flutter_application_gustov/data/models/settings_model.dart';

class DAOSettingsImpl extends BaseFirestoreRepositoryImpl<SettingsModel>
    implements DAOSettings {
  DAOSettingsImpl() : super("settings");

  @override
  SettingsModel fromJson(Map<String, dynamic> map) {
    return SettingsModel.fromJson(map);
  }

  @override
  Map<String, dynamic> toJson(SettingsModel t) {
    return t.toJson();
  }
}
