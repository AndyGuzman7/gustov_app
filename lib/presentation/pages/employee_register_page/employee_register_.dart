/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_eess/model/bautizated.dart';
import 'package:system_eess/model/class.dart';
import 'package:system_eess/model/gender.dart';
import 'package:system_eess/ui/global_controllers/validators.dart';
import 'package:system_eess/ui/global_widgets/inputs/custom_button.dart';
import 'package:system_eess/ui/global_widgets/inputs/custom_dropDown.dart';
import 'package:system_eess/ui/global_widgets/inputs/custom_input_field.dart';
import 'package:system_eess/ui/global_widgets/text/custom_title.dart';
import 'package:system_eess/ui/pages/students/widgets/bloc/form_create_student_dart_bloc.dart';
import 'package:system_eess/ui/pages/teachers/widgets/form_create_teacher/bloc/form_create_teacher_bloc.dart';

class EmployeeRegisterPage extends StatelessWidget {
  final Class classModel;
  const EmployeeRegisterPage({super.key, required this.classModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 15,
        left: 15,
        right: 15,
      ),
      child: SingleChildScrollView(
        child:
            BlocBuilder<FormCreateStudentDartBloc, FormCreateStudentDartState>(
          builder: (contextBloc, state) {
            final bloc = contextBloc.read<FormCreateStudentDartBloc>();
            return Form(
              key: bloc.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTitle(
                    title: "Registro",
                    subTitle: "Registro de un nuevo studiante",
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          onChanged: (value) => bloc.add(
                            FormCreateStudentDartEvent.nameChanged(value),
                          ),
                          isCapitalize: true,
                          icon: const Icon(Icons.person_2_outlined),
                          label: "Nombre",
                          validator: Validators.validationText,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomInputField(
                          onChanged: (value) => bloc.add(
                            FormCreateStudentDartEvent.nameSecondChanged(value),
                          ),
                          isCapitalize: true,
                          icon: const Icon(Icons.person_2_outlined),
                          label: "Segundo Nombre",
                          validator: Validators.validationText,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          onChanged: (value) => bloc.add(
                            FormCreateStudentDartEvent.lastNameChanged(value),
                          ),
                          isCapitalize: true,
                          icon: const Icon(Icons.person_2_outlined),
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
                            FormCreateStudentDartEvent.lastNameSecondChanged(
                                value),
                          ),
                          icon: const Icon(Icons.person_2_outlined),
                          label: "Segundo Apellido",
                          isCapitalize: true,
                          validator: Validators.validationText,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SettingsWidget<Bautizated>(
                          onChanged: (value) => bloc.add(
                            FormCreateStudentDartEvent.bautizatedChanged(value),
                          ),
                          hint: 'Bautizo',
                          items: [
                            Bautizated("Si Bautizado", true),
                            Bautizated("No Bautizado", false),
                          ],
                          validator: Validators.validationNull,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SettingsWidget<Gender>(
                          onChanged: (value) => bloc.add(
                            FormCreateStudentDartEvent.genderChanged(value),
                          ),
                          hint: 'Genero',
                          items: [
                            Gender("Masculino", "M"),
                            Gender("Femenino", "F"),
                          ],
                          validator: Validators.validationNull,
                        ),
                      )
                    ],
                  ),
                  CustomInputField(
                    onChanged: (value) => bloc.add(
                      FormCreateStudentDartEvent.phoneChanged(value),
                    ),
                    inputType: TextInputType.phone,
                    icon: const Icon(Icons.phone),
                    label: "Numero de Celular",
                    validator: Validators.validationPhone,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Fecha de Nacimiento"),
                  DateOfBirthComboBox(
                    onChanged: (DateTime date) => bloc
                        .add(FormCreateStudentDartEvent.birthDateChanged(date)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    height: 48,
                    textButton: 'Registrar',
                    onPressed: () => bloc.add(
                      FormCreateStudentDartEvent.loginSubmitted(
                          classModel, contextBloc),
                    ),
                  ),
                ],
              ),
            );
          },
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
*/