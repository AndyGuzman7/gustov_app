import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/routes/routes.dart';
import 'package:flutter_application_gustov/domain/entities/employee_entity.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee/employee_state.dart';
import 'package:flutter_application_gustov/presentation/pages/employee_register_page/employee_register_.dart';
import 'package:flutter_application_gustov/presentation/widgets/body/body_base.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeBloc>(
      create: (context) => sl<EmployeeBloc>()..add(const InitEvent()),
      child: const EmployeeView(),
    );
  }
}

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(context, Routes.employeesRegister);
                },
              ),
            )
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
