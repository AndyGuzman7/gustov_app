import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/domain/usecases/signout_session.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/session/session_bloc.dart';
import 'package:flutter_application_gustov/presentation/pages/home_page/widgets/item_button.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocSession = sl<SessionBloc>();
    final typeUser = blocSession.state.user!.position;
    final idMember = blocSession.state.user!.id;
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
      ),
      //drawer: const NavigatorDrawer(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (typeUser == "supervizor")
                      Row(
                        children: [
                          Expanded(
                            child: ItemButton(
                              textTitle: "Empleados",
                              pageRoute: Routes.employee,
                              textSubTitle: 'Empleados Gustov',
                              iconButtonItem:
                                  Icon(Icons.supervised_user_circle),
                            ),
                          ),
                          SizedBox(width: 8), // Espacio entre los widgets
                          Expanded(
                            child: const ItemButton(
                              textTitle: "Vacaciones",
                              pageRoute: Routes.requestVacation,
                              textSubTitle: 'Solcitudes vacaciones',
                              iconButtonItem: Icon(
                                Icons.class_,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    SizedBox(
                      height: 8,
                    ),
                    if (typeUser == "UserTypes.ADMIN" ||
                        typeUser == "UserTypes.DIRECTIVE")
                      Row(
                        children: [
                          Expanded(
                            child: ItemButton(
                              textTitle: "Registros",
                              pageRoute: Routes.login,
                              textSubTitle: 'Registros de tarjetas',
                              iconButtonItem: Icon(Icons.dock),
                            ),
                          ),
                          SizedBox(width: 8), // Espacio entre los widgets
                          Expanded(
                            child: const ItemButton(
                              textTitle: "Clases",
                              pageRoute: Routes.login,
                              textSubTitle: 'Clases UAB',
                              iconButtonItem: Icon(
                                Icons.class_,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    SizedBox(
                      height: 8,
                    ),
                    if (typeUser == "UserTypes.TEACHER")
                      Row(
                        children: [
                          Expanded(
                            child: ItemButton(
                              textTitle: "Mi Tarjeta",
                              pageRoute: Routes.splash,
                              arguments: {"idTeacher": idMember},
                              textSubTitle: 'Registros de clase',
                              iconButtonItem: Icon(
                                Icons.library_add_check,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(width: 8), // Espacio entre los widgets
                          Expanded(
                            child: ItemButton(
                              textTitle: "Mi clase",
                              pageRoute: Routes.splash,
                              arguments: {"idTeacher": idMember},
                              textSubTitle: 'Clases UAB',
                              iconButtonItem: Icon(
                                Icons.class_,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    SizedBox(
                      height: 8,
                    ),
                    if (typeUser == "UserTypes.TEACHER")
                      Row(
                        children: [
                          Expanded(
                            child: ItemButton(
                              textTitle: "Mi estudiantes",
                              pageRoute: Routes.splash,
                              arguments: {"idTeacher": idMember},
                              textSubTitle: 'Miembros de clase',
                              iconButtonItem: Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(width: 8), // Espacio entre los widgets
                          Expanded(
                            child: ItemButton(
                              textTitle: "Mi clase",
                              pageRoute: Routes.splash,
                              arguments: {"idTeacher": idMember},
                              textSubTitle: 'Clases UAB',
                              iconButtonItem: Icon(
                                Icons.class_,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    /*Center(
                  child: ElevatedButton(
                      onPressed: () {
                        EmailService('andyguzman117@gmail.com', 'Hola', 'sasd')
                            .sendEmail();
                      },
                      child: Text('Presionar Botón')))*/
                  ]),
              Text("Funciones"),
              CustomButton(
                textButton: 'Cerrar sesión',
                onPressed: () async {
                  final usecase = sl<SignoutSessionUseCase>();
                  await usecase();
                  blocSession.removerUser();

                  //if (!context.mounted) return;
                  Future.microtask(() {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
