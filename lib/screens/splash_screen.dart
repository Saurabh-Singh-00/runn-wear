import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runn_wear/blocs/blocs.dart';
import 'package:runn_wear/helpers/helpers.dart';
import 'package:runn_wear/screens/my_runns_screen.dart';
import 'package:runn_wear/screens/sign_in_screen.dart';
import 'package:wear/wear.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          pushReplacementRoute(context, MyRunnScreen());
        } else {
          pushReplacementRoute(context, SignInScreen());
        }
      },
      child: WatchShape(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Signing you in..."),
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
