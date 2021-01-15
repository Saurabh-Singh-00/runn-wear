import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:runn_wear/blocs/blocs.dart';
import 'package:runn_wear/models/marathon.dart';
import 'package:runn_wear/screens/widgets/time_component.dart';
import 'package:wear/wear.dart';

class RaceScreen extends StatelessWidget {
  final Marathon marathon;

  const RaceScreen({Key key, this.marathon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final RaceBloc raceBloc = BlocProvider.of<RaceBloc>(context);

    return WatchShape(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<RaceBloc, RaceState>(
          cubit: raceBloc,
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<int>(
                        initialData: 0,
                        stream: raceBloc.stopWatchTimer.minuteTime,
                        builder: (context, snapshot) {
                          return TimeComponent(
                            data: "${snapshot.data ~/ 60}",
                            title: "HRS",
                          );
                        },
                      ),
                      StreamBuilder<int>(
                        initialData: 0,
                        stream: raceBloc.stopWatchTimer.minuteTime,
                        builder: (context, snapshot) {
                          return TimeComponent(
                            data: "${snapshot.data % 60}",
                            title: "MINS",
                          );
                        },
                      ),
                      StreamBuilder<int>(
                        initialData: 0,
                        stream: raceBloc.stopWatchTimer.secondTime,
                        builder: (context, snapshot) {
                          return TimeComponent(
                            data: "${snapshot.data % 60}",
                            title: "SECS",
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BlocBuilder<RaceBloc, RaceState>(
                          builder: (context, state) {
                            return RaisedButton(
                              shape: StadiumBorder(),
                              color: (state is RaceStarted)
                                  ? Colors.redAccent
                                  : Colors.green,
                              onPressed: () async {
                                if (state is RaceStarted) {
                                  raceBloc.add(EndRace());
                                  Navigator.of(context).pop();
                                } else {
                                  GoogleSignInAccount acc =
                                      BlocProvider.of<AuthBloc>(context)
                                          .account;
                                  // print(acc.email);
                                  // Either<Exception, Position> either =
                                  //     await raceBloc.determinePosition();
                                  // either.fold((l) {
                                  //   print("Location");
                                  // }, (r) {

                                  // });
                                  raceBloc
                                      .add(StartRace(marathon.id, acc.email));
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                child: Text(
                                  (state is RaceStarted) ? "Stop" : "Start",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
