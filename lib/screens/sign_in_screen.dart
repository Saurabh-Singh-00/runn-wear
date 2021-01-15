import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runn_wear/blocs/blocs.dart';
import 'package:runn_wear/helpers/helpers.dart';
import 'package:runn_wear/screens/screens.dart';
import 'package:wear/wear.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    pushReplacementRoute(context, MyRunnScreen());
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please Sign In"),
                      ),
                    );
                  }
                },
                child: RaisedButton.icon(
                  onPressed: () {
                    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
                    authBloc.add(Authenticate());
                  },
                  icon: Icon(FontAwesomeIcons.google),
                  label: Text("Sign In"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
