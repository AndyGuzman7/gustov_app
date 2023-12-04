import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';

class CardVacationRequest extends StatelessWidget {
  final VactionRequestEntity vacationRequestEntity;
  const CardVacationRequest({super.key, required this.vacationRequestEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
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
