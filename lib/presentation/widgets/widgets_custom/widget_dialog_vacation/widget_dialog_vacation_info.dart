import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/domain/entities/settings_entity.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/dialog/dialog_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_bloc.dart';
import 'package:flutter_application_gustov/presentation/widgets/loading_widget/loading_widget.dart';
import 'package:flutter_application_gustov/presentation/widgets/widgets_custom/widget_vacation_info/widget_vacation_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetDialogVacationInfo extends StatelessWidget {
  final VacationRequestEntity vacationRequestEntity;
  final List<SettingsEntity> listScale;
  const WidgetDialogVacationInfo({
    super.key,
    required this.vacationRequestEntity,
    required this.listScale,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DialogBloc>(
      create: (context) => sl<DialogBloc>()
        ..add(
          InitDialogEvent(vacationRequestEntity, listScale),
        ),
      child: ViewDialogVacationInfo(),
    );
  }
}

class ViewDialogVacationInfo extends StatelessWidget {
  ViewDialogVacationInfo({
    super.key,
  });
  final session = sl<SessionBloc>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DialogBloc>();
    return BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) {
        if (state is DialogLoading) {
          return const LoadingWidget();
        }
        final vacationRequestEntity = state.vacationRequest;
        final user = vacationRequestEntity!.employeeEntity;
        return AlertDialog(
          title: const Text('Solicitud de vacaciones'),
          content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: WidgetVacationInfo(
                  name: user!.fullName,
                  description: vacationRequestEntity.description!,
                  email: user.email!,
                  dateStart: vacationRequestEntity.dateVacationInit!,
                  listScale: state.settingRequests!,
                  dateStartWorking: user.workStartDate!,
                ),
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
            if (session.state.user!.position == "supervizor" &&
                context
                        .read<DialogBloc>()
                        .state
                        .vacationRequest!
                        .autorizationVacation! !=
                    1)
              Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () {
                      bloc.add(DenegatedVacationDialogEvent(context));
                    },
                    child: const Text('Rechazar vacación'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () {
                      bloc.add(AcceptVacationDialogEvent(context));
                    },
                    child: const Text('Aceptar vacación'),
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}
