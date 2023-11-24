import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/login/login_event.dart';
import 'package:flutter_application_gustov/presentation/bloc/login/login_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_input_field_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_textButton.dart';
import 'package:flutter_application_gustov/presentation/widgets/text/custom_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final bloc = sl<LoginBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<LoginBloc, LoginState>(
              bloc: bloc,
              builder: (contextBloc, state) {
                return Form(
                  key: bloc.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const CustomTitle2(
                        isBoldTitle: true,
                        title: 'Hola! Bienvenido de nuevo',
                        subTitle: 'Inicie sesión en su cuenta',
                      ),
                      const SizedBox(height: 20),
                      CustomInputFieldState(
                        validator: bloc.validationEmail,
                        inputType: TextInputType.emailAddress,
                        icon: const Icon(Icons.email),
                        label: "Correo",
                        onChanged: (value) => bloc.add(
                          EmailChangedLoginEvent(value),
                        ),
                      ),
                      CustomInputFieldState(
                        validator: bloc.validationPassword,
                        icon: const Icon(Icons.security_outlined),
                        label: "Contraseña",
                        onChanged: (value) => bloc.add(
                          PasswordChangedLoginEvent(value),
                        ),
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                          textButton: 'Iniciar Sesión',
                          onPressed: () =>
                              bloc.add(LoginSubmittedLoginEvent(context))),
                      const SizedBox(height: 50),
                      const Text(
                        '¿No tengo una cuenta?',
                        textAlign: TextAlign.center,
                      ),
                      const CustomTextButton(
                        text: 'Comuníquese con la empresa',
                      )
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
