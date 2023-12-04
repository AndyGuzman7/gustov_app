import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/util/validators.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request_create/vacation_request_create_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/card/card_vacation_request.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_input_field_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/text/custom_title.dart';
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
                List<VactionRequestEntity>?>(
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
                              showDialog(
                                context: contextBloc,
                                builder: (BuildContext context) {
                                  return _dialog(context, contextBloc);
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
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

  _dialog(BuildContext context, BuildContext contextBloc) {
    final bloc = contextBloc.read<VacationRequestCreateBloc>();
    final user = sl<SessionBloc>().state;
    return AlertDialog(
      title: Text('Solicitud de vacaciones'),
      content: Container(
        width: double.maxFinite,
        child: Form(
          key: bloc.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Nombre: ${user.user!.name!}"),
              Text("Email: ${user.user!.email!}"),
              Divider(),
              Text(
                  "Añade una descripción de la solictud de vacaciones del restaurante Gustov"),
              CustomInputFieldState(
                validator: Validators.validationText,
                icon: const Icon(Icons.description),
                label: "Descripción",
                onChanged: (value) => bloc.add(
                  DescriptionChangedRegisterEvent(value),
                ),
              ),

              // Agrega más campos de formulario según sea necesario
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Cerrar el diálogo cuando se presiona "Cancelar"
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            bloc.add(RegisterVacationSubmittedRegisterEvent(context));
            //Navigator.of(context).pop();
          },
          child: Text('Solicitar'),
        ),
      ],
    );
  }
}
