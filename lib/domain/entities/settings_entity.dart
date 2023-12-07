import 'package:equatable/equatable.dart';
import 'package:flutter_application_gustov/data/models/settings_model.dart';
import 'package:flutter_application_gustov/data/models/vacation_request_model.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';

class SettingsEntity extends Equatable {
  final String description;
  final String scale;
  final int vacationDays;
  final int timeMin;
  final int timeMax;

  const SettingsEntity({
    required this.description,
    required this.scale,
    required this.vacationDays,
    required this.timeMin,
    required this.timeMax,
  });

  factory SettingsEntity.fromModel(
    SettingsModel settingsModel,
  ) {
    return SettingsEntity(
      description: settingsModel.description,
      scale: settingsModel.scale,
      vacationDays: settingsModel.vacationDays,
      timeMax: settingsModel.timeMax,
      timeMin: settingsModel.timeMin,
    );
  }

  @override
  List<Object?> get props {
    return [
      scale,
      description,
      vacationDays,
      timeMax,
      timeMin,
    ];
  }
}
