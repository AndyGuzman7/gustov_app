part of 'splash_bloc.dart';

class SplashState {
  final String? route;
  SplashState({required this.route});

  static SplashState get initialState => SplashState(route: null);

  SplashState copyWith({String? route}) {
    return SplashState(
      route: route ?? this.route,
    );
  }
}
