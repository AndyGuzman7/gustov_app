import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeService {
  //Fechas de feriados en Bolivia
  static List<DateTime> ignoredDate = [
    DateTime(0000, 1, 1),
    DateTime(0000, 5, 1),
    DateTime(0000, 8, 6),
    DateTime(0000, 3, 23),
    DateTime(0000, 11, 1),
    DateTime(0000, 12, 25),
  ];

  static formatedDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static Map<String, dynamic> antiquityCalculate(DateTime dateStart) {
    final dateNow = DateTime.now();
    final Duration antiquity = dateNow.difference(dateStart);
    if (antiquity.inDays < 365) {
      return {'type': 'day', 'value': antiquity.inDays};
    } else {
      final years = (antiquity.inDays / 365).floor();
      return {'type': 'year', 'value': years};
    }
  }

  static timeVacationCalculate(int timeYears, List<SettingsEntity> listScale) {
    for (var rule in listScale) {
      if (timeYears >= rule.timeMin && timeYears <= rule.timeMax) {
        return rule.vacationDays;
      }
    }
    return 0;
  }

  static antiquityLiteral(Map<String, dynamic> antiquity) {
    if (antiquity['type'] == 'day') {
      return '${antiquity['value']} días.';
    } else {
      final years = antiquity['value'];
      return '$years ${years == 1 ? 'año' : 'años.'}';
    }
  }

  static List<DateTime> quantityDate(int days, DateTime dateInit) {
    final daysVacation = <DateTime>[];
    int i = 0;
    while (daysVacation.length < days) {
      final date = dateInit.add(Duration(days: i));
      if (date.weekday != 7 &&
          ignoredDate.firstWhereOrNull((element) =>
                  element.day == date.day && element.month == date.month) ==
              null) {
        daysVacation.add(date);
      }
      i++;
    }

    return daysVacation;
  }
}
