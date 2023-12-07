import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/core/services/date_time_service.dart';
import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';

class WidgetVacationInfo extends StatelessWidget {
  final String name;
  final String email;
  final DateTime dateStart;
  final DateTime dateStartWorking;
  final String description;
  final List<SettingsEntity> listScale;

  const WidgetVacationInfo({
    super.key,
    required this.name,
    required this.email,
    required this.dateStart,
    required this.description,
    required this.listScale,
    required this.dateStartWorking,
  });

  @override
  Widget build(BuildContext context) {
    final antiquity = DateTimeService.antiquityCalculate(dateStartWorking);
    final int timeYears = antiquity['type'] == 'year' ? antiquity['value'] : 0;

    final int daysVacation =
        DateTimeService.timeVacationCalculate(timeYears, listScale);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _featureText('Nombre', name),
        _featureText('Email', email),
        _featureText('Antiguedad', DateTimeService.antiquityLiteral(antiquity)),
        const Divider(),
        _featureText('Días de vacación habiles', '$daysVacation dias.'),
        const Divider(),
        _featureText(
          'Fecha de inicio',
          DateTimeService.formatedDate(dateStart),
        ),
        const Text("Fechas habiles:"),
        Column(
          children: _buildWidget(
              DateTimeService.quantityDate(daysVacation, dateStart)),
        ),
        const Divider(),
        const Text(
          "Descripción de vacación:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(description)
      ],
    );
  }

  _featureText(String featureTitle, String featureText) {
    return Row(
      children: [
        Text(
          "$featureTitle:",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          featureText,
        ),
      ],
    );
  }

  _buildWidget(List<DateTime> dateList) {
    List<Widget> listWidget = [];
    List<Widget> listWidgetRow = [];
    int i = 1;
    for (var date in dateList) {
      String formattedDate = DateTimeService.formatedDate(date);
      final widget = Container(
        color: Colors.blue,
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(3),
        child: Text(
          formattedDate,
          style: const TextStyle(color: Colors.white),
        ),
      );
      listWidgetRow.add(widget);
      if (i == 3) {
        listWidget.add(Row(
          children: listWidgetRow,
        ));
        listWidgetRow = [];
        i = 0;
      }
      i++;
    }
    return listWidget;
  }
}
