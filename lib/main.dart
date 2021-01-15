import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runn_wear/blocs/blocs.dart';
import 'package:runn_wear/injector/injector.dart';
import 'package:runn_wear/screens/screens.dart';

void main() {
  injector.setup();
  runApp(
    RunnWear(
      authBloc: AuthBloc(),
    ),
  );
}

class RunnWear extends StatelessWidget {
  final AuthBloc authBloc;

  RunnWear({Key key, this.authBloc}) : super(key: key) {
    this.authBloc?.add(AuthenticateSilently());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: authBloc),
        BlocProvider<MyrunnBloc>(
          create: (_) => MyrunnBloc(authBloc),
          lazy: false,
        ),
        BlocProvider<ParticipationBloc>(
          create: (_) => ParticipationBloc(),
        ),
        BlocProvider<RaceBloc>(
          create: (_) => RaceBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: "Runn",
        home: SplashScreen(),
      ),
    );
  }
}
