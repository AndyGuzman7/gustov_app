import 'package:dio/dio.dart';
import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/data/models/settings_model.dart';
import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';
import 'package:flutter_application_gustov/domain/repository/settings_repository.dart';

import '../data_sources/remote/dao.interfaces/dao_settings.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final DAOSettings _daoSettings;

  SettingsRepositoryImpl(this._daoSettings);

  @override
  Future<DataState<List<SettingsEntity>>> getVacationRequest() async {
    try {
      final list = await _daoSettings.getAll();

      return DataSuccess(convertListModelsToEntities(list));
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  List<SettingsEntity> convertListModelsToEntities(
    List<SettingsModel> list,
  ) {
    final newList = list.map((e) => SettingsEntity.fromModel(e)).toList();
    return newList;
  }
}
