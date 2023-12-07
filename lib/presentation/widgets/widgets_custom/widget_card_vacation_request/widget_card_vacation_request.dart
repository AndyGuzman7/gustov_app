import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/presentation/widgets/widgets_custom/widget_dialog_vacation/widget_dialog_vacation_info.dart';

class CardVacationRequest extends StatelessWidget {
  final VacationRequestEntity vacationRequestEntity;
  final List<SettingsEntity> listScale;
  const CardVacationRequest(
      {super.key,
      required this.vacationRequestEntity,
      required this.listScale});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return WidgetDialogVacationInfo(
                vacationRequestEntity: vacationRequestEntity,
                listScale: listScale,
              );
            },
          );
        },
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Solicitud de vacación"),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: Column(
                      children: [
                        const Text("Descripción:"),
                        Text(
                          vacationRequestEntity.description!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      stateAutorization(
                        vacationRequestEntity.autorizationVacation!,
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: const Icon(Icons.free_breakfast),
                  ),
                  Text(
                    "Fecha Solicitud: ${vacationRequestEntity.dateRequest}",
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String stateAutorization(int state) {
    switch (state) {
      case 1:
        return "Estado: Aprobado";
      case 0:
        return "Estado: Pendiente";
      case -1:
        return "Estado: Desaprobado";
      default:
        return "Sin estado";
    }
  }
}
