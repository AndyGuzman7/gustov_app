import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/domain/entities/vacation_request_entity.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/vacation_request_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/body/body_base.dart';
import 'package:flutter_application_gustov/presentation/widgets/widgets_custom/widget_card_vacation_request/widget_card_vacation_request.dart';
import 'package:flutter_application_gustov/presentation/widgets/loading/loading.dart';
import 'package:flutter_application_gustov/presentation/widgets/loading_widget/loading_widget.dart';
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
    final bloc = context.read<VacationRequestBloc>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Solicitudes vacaciones"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16.0),
            BlocSelector<VacationRequestBloc, VacationRequestState,
                List<VacationRequestEntity>?>(
              selector: (state) => state.vacationRequest,
              builder: (_, list) {
                if (list == null) {
                  return const SizedBox(
                    child: LoadingWidget(),
                  );
                }

                if (list.isEmpty) {
                  return const SizedBox(
                    child: Text("No hay registros"),
                  );
                }
                final bloc = _.read<VacationRequestBloc>();
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
