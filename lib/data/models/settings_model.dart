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
      'vacationDays': vacationDays,
      'timeMin': timeMin,
      'timeMax': timeMax,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      description: json['description'],
      scale: json['scale'],
      vacationDays: json['vacationDays'],
      timeMin: json['working_time']['time_min'],
      timeMax: json['working_time']['timeMax'],
    );
  }
}
