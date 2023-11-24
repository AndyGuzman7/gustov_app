import 'package:flutter/material.dart';
import 'package:flutter_application_gustov/inject_dependencies.dart';
import 'package:flutter_application_gustov/presentation/bloc/splash/splash_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  final bloc = sl<SplashBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocListener<SplashBloc, SplashState>(
        bloc: bloc..add(InitialEvent()),
        listener: (context, state) {
          final routeName = state.route;

          if (routeName != null) {
            Navigator.pushReplacementNamed(context, routeName);
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ));
  }
}
