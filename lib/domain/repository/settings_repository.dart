import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<DataState<List<SettingsEntity>>> getVacationRequest();
}
