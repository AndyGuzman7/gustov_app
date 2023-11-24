import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/config/util/validators.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee_register/employee_register_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee_register/employee_register_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/employee_register/employee_register_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_input_field.dart';
import 'package:flutter_application_gustov/presentation/widgets/text/custom_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeRegisterPage extends StatelessWidget {
  EmployeeRegisterPage({super.key});

  final bloc = sl<EmployeeRegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 15,
              top: 15,
              left: 15,
              right: 15,
            ),
            child: BlocBuilder<EmployeeRegisterBloc, EmployeeRegisterState>(
              bloc: bloc,
              builder: (contextBloc, state) {
                return Form(
                  key: bloc.formKey,
                  child: Column(
                    children: [
                      CustomTitle(
                        title: "Registro",
                        subTitle: "Registro de un nuevo empleado",
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(255, 240, 240, 240)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Formulario de Registro"),
                            ]),
                      ),
                      CustomInputField(
                        onChanged: (value) => bloc.add(
                          NameChangedRegisterEvent(value),
                        ),
                        isCapitalize: true,
                        icon: const Icon(Icons.person),
                        label: "Nombre",
                        validator: Validators.validationText,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              onChanged: (value) => bloc.add(
                                LastNameChangedRegisterEvent(value),
                              ),
                              isCapitalize: true,
                              icon: const Icon(Icons.person),
                              label: "Primer Apellido",
                              validator: Validators.validationText,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: CustomInputField(
                              onChanged: (value) => bloc.add(
                                LastNameSecondChangedRegisterEvent(value),
                              ),
                              icon: const Icon(Icons.person),
                              label: "Segundo Apellido",
                              isCapitalize: true,
                              validator: Validators.validationText,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomInputField(
                        inputType: TextInputType.emailAddress,
                        onChanged: (value) => bloc.add(
                          EmailChangedRegisterEvent(value),
                        ),
                        isCapitalize: true,
                        icon: const Icon(Icons.person),
                        label: "Correo electronico",
                        validator: Validators.validationEmail,
                      ),
                      CustomButton(
                        height: 48,
                        textButton: 'Registrar',
                        onPressed: () => bloc.add(
                          RegisterSubmittedRegisterEvent(contextBloc),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

bool isValidEmail(String text) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text);
}
