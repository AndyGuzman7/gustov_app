import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/core/services/date_time_service.dart';
import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';

import 'package:pdf/widgets.dart' as pw;

class ContentPdfFormater {
  ContentPdfFormater(this.font);

  final pw.Font font;

  pw.Row _featureText(String featureTitle, String featureText) {
    return pw.Row(
      children: [
        pw.Text(
          "$featureTitle:",
          style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(
          width: 8,
        ),
        pw.Text(
          featureText,
          style: pw.TextStyle(
            font: font,
          ),
        ),
      ],
    );
  }

  pw.Widget buildContent({
    required String name,
    required String email,
    required DateTime dateStart,
    required DateTime dateStartWorking,
    required String description,
    required List<SettingsEntity> listScale,
    required bool authorization,
  }) {
    final antiquity = DateTimeService.antiquityCalculate(dateStartWorking);
    final int timeYears = antiquity['type'] == 'year' ? antiquity['value'] : 0;

    final int daysVacation =
        DateTimeService.timeVacationCalculate(timeYears, listScale);
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        _featureText('Nombre', name),
        _featureText('Email', email),
        _featureText('Antiguedad', DateTimeService.antiquityLiteral(antiquity)),
        pw.Divider(),
        _featureText('Días de vacación hábiles', '$daysVacation dias.'),
        pw.Divider(),
        _featureText(
          'Fecha de inicio',
          DateTimeService.formatedDate(dateStart),
        ),
        pw.Text(
          "Fechas hábiles de las vacaciones(No se tomaron dias festivos/feriados y domingos):",
          style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold),
        ),
        _buildWidget(DateTimeService.quantityDate(daysVacation, dateStart)),
        pw.Divider(),
        pw.Text(
          "Descripción de vacación:",
          style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          description,
          style: pw.TextStyle(font: font),
        ),
        pw.Text(
          "Estado:",
          style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          authorization ? 'Vacaciones aprobadas.' : 'Vacaciones rechazadas.',
          style: pw.TextStyle(
            font: font,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildWidget(List<DateTime> dateList) {
    List<pw.Widget> listWidget = [];
    List<pw.Widget> listWidgetRow = [];
    int i = 1;
    for (var date in dateList) {
      String formattedDate = DateTimeService.formatedDate(date);
      final widget = pw.Container(
        margin: pw.EdgeInsets.all(3),
        padding: pw.EdgeInsets.all(3),
        child: pw.Text(
          formattedDate,
          style: pw.TextStyle(
            font: font,
          ),
        ),
      );
      listWidgetRow.add(widget);
      if (i == 3) {
        listWidget.add(pw.Row(
          children: listWidgetRow,
        ));
        listWidgetRow = [];
        i = 0;
      }
      i++;
    }
    return pw.Column(
      children: listWidget,
    );
  }
}
