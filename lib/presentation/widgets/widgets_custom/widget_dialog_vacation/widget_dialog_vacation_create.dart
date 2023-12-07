import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/util/validators.dart';
import 'package:flutter_application_gustov/core/services/date_time_service.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_date_picker.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_input_field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WidgetDialogVacationCreate extends StatelessWidget {
  const WidgetDialogVacationCreate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = sl<SessionBloc>().state;
    return BlocBuilder<VacationRequestCreateBloc, VacationRequestCreateState>(
        builder: (context, state) {
      final bloc = context.read<VacationRequestCreateBloc>();
      final antiquity =
          DateTimeService.antiquityCalculate(user.user!.workStartDate!);
      final int timeYears =
          antiquity['type'] == 'year' ? antiquity['value'] : 0;

      final int daysVacation = DateTimeService.timeVacationCalculate(
          timeYears, state.settingRequests!);
      return AlertDialog(
        title: const Text('Solicitud de vacaciones'),
        content: SizedBox(
          width: double.maxFinite,
          child: Form(
            key: bloc.formKey,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _featureText('Nombre', user.user!.fullName),
                    _featureText('Email', user.user!.email!),
                    _featureText('Antiguedad',
                        DateTimeService.antiquityLiteral(antiquity)),
                    const Divider(),
                    _featureText(
                        'Días de vacación habiles', '$daysVacation dias.'),
                    const Divider(),
                    if (antiquity['type'] != 'day') ...[
                      const Text("Fecha de inicio de vacación."),
                      CustomImputDatePicker(
                        label: 'Seleccione fecha',
                        validator: Validators.validationNull,
                        onChanged: ((p0) {
                          if (p0 != null) {
                            bloc.add(
                              DateSelectedChangedRegisterEvent(p0),
                            );
                          }
                        }),
                      ),
                      const Text("Fechas habiles"),
                      BlocSelector<VacationRequestCreateBloc,
                          VacationRequestCreateState, DateTime?>(
                        selector: (state) => state.dateSelected,
                        builder: ((context, state) {
                          if (state != null) {
                            return Column(
                              children: _buildWidget(
                                  DateTimeService.quantityDate(
                                      daysVacation, state)),
                            );
                          }

                          return const SizedBox();
                        }),
                      ),
                      const Divider(),
                      const Text("Descripción de vacación."),
                      CustomInputFieldState(
                        validator: Validators.validationText,
                        icon: const Icon(Icons.description),
                        label: "Descripción",
                        onChanged: (value) => bloc.add(
                          DescriptionChangedRegisterEvent(value),
                        ),
                      ),
                    ] else
                      Text(
                        "Su estadia en la empresa no supera los 1 año, por lo que no tiene hailitado las solicitudes de vacaciones.",
                        style: TextStyle(color: Colors.red),
                      )
                  ]),
            ),
          ),
        ),
        actions: [
          if (antiquity['type'] != 'day') ...[
            TextButton(
              onPressed: () {
                bloc.add(
                  const CleanDialogChangedRegisterEvent(),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                bloc.add(RegisterVacationSubmittedRegisterEvent(context));
              },
              child: const Text('Solicitar'),
            ),
          ] else
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
        ],
      );
    });
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
      String formattedDate = DateFormat('dd-MM-yyyy').format(date);
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
