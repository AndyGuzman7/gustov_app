import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/routes/routes.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/body/body_base.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeBloc>(
      create: (context) => sl<EmployeeBloc>()..add(const InitEvent()),
      child: EmployeeView(),
    );
  }
}

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<StudentsBloc>(context)
          .add(StudentsEvent.started(context));
    });*/
    final bloc = context.read<EmployeeBloc>();
    return BodyBase(
      "Empleados Gustov",
      [
        Row(
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
                  /*await showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: false,
                    context: context,
                    builder: (_) {
                      return BlocProvider<FormCreateStudentDartBloc>(
                          create: (context) => FormCreateStudentDartBloc(
                                BlocProvider.of<SessionBloc>(
                                  context,
                                ),
                              ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Logotipo de "jalar hacia arriba"
                                Center(
                                  child: Icon(
                                    Icons.link,
                                    color: Colors.grey,
                                  ),
                                ),
                                // Contenido del formulario o cualquier otro elemento
                                FormCreateStudent(
                                  classModel: bloc.state.classModel!,
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                  if (!context.mounted) return;
                  BlocProvider.of<StudentsBloc>(context)
                      .add(StudentsEvent.started(context));*/
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        BlocSelector<EmployeeBloc, EmployeeState, List<EmployeeEntity>?>(
          selector: (state) => state.employees,
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
                        listTeachers[index].name!,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        listTeachers[index].email!,
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
