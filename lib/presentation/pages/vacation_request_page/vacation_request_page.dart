import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/body/body_base.dart';
import 'package:flutter_application_gustov/presentation/widgets/card/card_vacation_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VacationRequestPage extends StatelessWidget {
  const VacationRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VacationRequestBloc>(
      create: (context) =>
          sl<VacationRequestBloc>()..add(const GetVacationRequest()),
      child: const VacationRequestView(),
    );
  }
}

class VacationRequestView extends StatelessWidget {
  const VacationRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<VacationRequestBloc>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("Solicitudes vacaciones"),
            const SizedBox(height: 16.0),
            BlocSelector<VacationRequestBloc, VacationRequestState,
                List<VactionRequestEntity>?>(
              selector: (state) => state.vacationRequest,
              builder: (_, list) {
                print("hola");
                if (list == null) {
                  return const SizedBox(
                    child: Text("Ocurrio un problema."),
                  );
                }

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
                      return CardVacationRequest(
                        vacationRequestEntity: vacationRequestEntity,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
