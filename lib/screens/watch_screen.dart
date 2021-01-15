import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wear/wear.dart';

class WatchScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Welcome to Runn"),
              ),
              RaisedButton(
                child: Text("Sign In", style: TextStyle(color: Colors.white),),
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                onPressed: () async {
                  GoogleSignInAccount account = await _googleSignIn.signIn();
                  print(account.email);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
