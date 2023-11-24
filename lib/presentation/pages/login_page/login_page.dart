import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_application_gustov/presentation/bloc/login/login_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_button.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_input_field_state.dart';
import 'package:flutter_application_gustov/presentation/widgets/inputs/custom_textButton.dart';
import 'package:flutter_application_gustov/presentation/widgets/text/custom_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Image image = Image.asset('images/logo.webp');

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (contextBloc, state) {
                return Form(
                  key: contextBloc.read<LoginBloc>().formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        child: image,
                      ),
                      const SizedBox(height: 30),
                      const CustomTitle2(
                        isBoldTitle: true,
                        title: 'Hola! Bienvenido de nuevo',
                        subTitle: 'Inicie sesión en su cuenta',
                      ),
                      const SizedBox(height: 20),
                      CustomInputFieldState(
                        /*  validator:
                            contextBloc.read<LoginBloc>().validationEmail,*/
                        inputType: TextInputType.emailAddress,
                        icon: const Icon(Icons.email),
                        label: "Correo",
                        /*onChanged: (value) => contextBloc
                            .read<LoginBloc>()
                            .add(LoginFormEvent.emailChanged(value)),*/
                      ),
                      CustomInputFieldState(
                        validator:
                            contextBloc.read<LoginBloc>().validationPassword,
                        icon: const Icon(Icons.security_outlined),
                        label: "Contraseña",
                        /* onChanged: (value) => contextBloc
                            .read<LoginBloc>()
                            .add(LoginFormEvent.passwordChanged(value)),*/
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        textButton: 'Iniciar Sesión',
                        /*onPressed: () => contextBloc
                              .read<LoginBloc>()
                              .add(LoginFormEvent.loginSubmitted(context))),*/
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        '¿No tengo una cuenta?',
                        textAlign: TextAlign.center,
                      ),
                      const CustomTextButton(
                        text: 'Comuníquese con su Directiva',
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
