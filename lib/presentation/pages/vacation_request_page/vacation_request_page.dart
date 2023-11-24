import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/routes/routes.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_state.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_state.dart';
import 'package:flutter_application_gustov/presentation/pages/employee_register_page/employee_register_.dart';
import 'package:flutter_application_gustov/presentation/widgets/body/body_base.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VacationRequestPage extends StatelessWidget {
  const VacationRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VacationRequestBloc>(
      create: (context) =>
          sl<VacationRequestBloc>()..add(const GetVacationRequest()),
      child: VacationRequestView(),
    );
  }
}

class VacationRequestView extends StatelessWidget {
  const VacationRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<StudentsBloc>(context)
          .add(StudentsEvent.started(context));
    });*/
    final bloc = context.read<VacationRequestBloc>();
    return BodyBase(
      "Solicitudes vacaciones",
      [
        /*Row(
          children: [
            Expanded(
              child: SizedBox(),
            ),
            SizedBox(width: 8), // Espacio entre los widgets
            Expanded(
              child: CustomButton(
                height: 48,
                icon: Icon(Icons.add),
                textButton: 'Empleado',
                onPressed: () async {
                  Navigator.pushNamed(context, Routes.employeesRegiste);
                  /*await showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: false,
                    context: context,
                    builder: (_) {
                      return EmployeeRegisterPage();
                    },
                  );*/
                },
              ),
            )
          ],
        ),*/
        SizedBox(height: 16.0),
        BlocSelector<VacationRequestBloc, VacationRequestState,
            List<VacationRequestEntity>?>(
          selector: (state) => state.vacationRequest,
          builder: (_, list) {
            if (list == null)
              return const SizedBox(
                child: Text(""),
              );

            if (list.isEmpty) {
              return const SizedBox(
                child: Text("No hay registros"),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: list.length, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  final vacationRequestEntity = list[index];
                  return Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Solicitud de vacación"),
                        ListTile(
                          leading: Icon(Icons.description),
                          title: Column(
                            children: [
                              Text("Descripción:"),
                              Text(
                                vacationRequestEntity.description!,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            stateAutorization(
                              vacationRequestEntity.autorizationVacation!,
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Icon(Icons.free_breakfast),
                          onTap: () {
                            /*Navigator.pushNamed(context, Routes.STUDENT_DATA_PAGE,
                                  arguments: listTeachers[index]);*/
                            // Acción al hacer clic en un elemento
                          },
                        ),
                        Text(
                          "Fecha Solicitud: " +
                              vacationRequestEntity.dateRequest.toString(),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
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
