class SettingsModel {
  final String description;
  final String scale;
  final int vacationDays;
  final int timeMin;
  final int timeMax;

  SettingsModel({
    required this.description,
    required this.scale,
    required this.vacationDays,
    required this.timeMin,
    required this.timeMax,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'scale': scale,
      'vacation_days': vacationDays,
      'timeMin': timeMin,
      'timeMax': timeMax,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    final model = SettingsModel(
      description: json['description'] ?? '',
      scale: json['scale'] ?? '',
      vacationDays: json['vacation_days'] ?? 0,
      timeMin: json['working_time_range']['time_min'] ?? 0,
      timeMax: json['working_time_range']['time_max'] ?? 0,
    );

    return model;
  }
}
