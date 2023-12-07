import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/widgets_custom/widget_card_vacation_request/widget_card_vacation_request.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_application_gustov/presentation/widgets/text/custom_title.dart';
import 'package:flutter_application_gustov/presentation/widgets/widgets_custom/widget_dialog_vacation/widget_dialog_vacation_create.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VacationRequestCreatePage extends StatelessWidget {
  const VacationRequestCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VacationRequestCreateBloc>(
      create: (context) => sl<VacationRequestCreateBloc>()
        ..add(const StartedVacationRequestCreateEvent()),
      child: const VacationRequestCreateView(),
    );
  }
}

class VacationRequestCreateView extends StatelessWidget {
  const VacationRequestCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const CustomTitle2(
              title: 'Solicitud de vacación',
              textAlignTitle: TextAlign.center,
            ),
            const SizedBox(
              height: 200,
            ),
            BlocSelector<VacationRequestCreateBloc, VacationRequestCreateState,
                List<VacationRequestEntity>?>(
              selector: (state) => state.vacationRequest,
              builder: (contextBloc, list) {
                if (list == null) {
                  return const SizedBox(
                    child: Text("Cargando..."),
                  );
                }

                if (list.isEmpty) {
                  return SizedBox(
                    child: Column(
                      children: [
                        const Center(
                            child: Text("No hay solicitud de vacaciones")),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            textButton: 'Solicitar',
                            onPressed: () {
                              final bloc =
                                  BlocProvider.of<VacationRequestCreateBloc>(
                                      context);
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return BlocProvider.value(
                                    value: bloc,
                                    child: const WidgetDialogVacationCreate(),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }

                final bloc = contextBloc.read<VacationRequestCreateBloc>();
                return Expanded(
                  child: ListView.builder(
                    itemCount: list.length, // Número de elementos en la lista
                    itemBuilder: (context, index) {
                      final vacationRequestEntity = list[index];
                      return CardVacationRequest(
                        vacationRequestEntity: vacationRequestEntity,
                        listScale: bloc.state.settingRequests!,
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
