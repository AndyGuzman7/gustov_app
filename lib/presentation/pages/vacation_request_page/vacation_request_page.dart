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
          builder: (_, listTeachers) {
            if (listTeachers == null)
              return const SizedBox(
                child: Text(""),
              );

            if (listTeachers.isEmpty) {
              return const SizedBox(
                child: Text("No hay registros"),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount:
                    listTeachers.length, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        listTeachers[index].description!,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        listTeachers[index].autorizationVacation.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Icon(Icons.phone),
                      onTap: () {
                        /*Navigator.pushNamed(context, Routes.STUDENT_DATA_PAGE,
                            arguments: listTeachers[index]);*/
                        // Acción al hacer clic en un elemento
                      },
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
}
