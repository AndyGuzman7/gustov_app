import 'package:flutter_application_gustov/core/resources/data_state.dart';
import 'package:flutter_application_gustov/core/usecases/usecase.dart';
import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';
import 'package:flutter_application_gustov/domain/repository/settings_repository.dart';

class GetScaleDaysVacationUseCase
    implements UseCase<DataState<List<SettingsEntity>>, void> {
  final SettingsRepository _settingsRepository;

  GetScaleDaysVacationUseCase(this._settingsRepository);
  @override
  Future<DataState<List<SettingsEntity>>> call({void params}) async {
    return await _settingsRepository.getVacationRequest();
  }
}
