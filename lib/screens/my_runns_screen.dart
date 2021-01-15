import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runn_wear/blocs/blocs.dart';
import 'package:runn_wear/helpers/helpers.dart';
import 'package:runn_wear/injector/injector.dart';
import 'package:runn_wear/models/marathon.dart';
import 'package:runn_wear/repositories/marathon_repository.dart';
import 'package:runn_wear/screens/screens.dart';
import 'package:wear/wear.dart';

class MyRunnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<MyrunnBloc, MyrunnState>(
          cubit: BlocProvider.of<MyrunnBloc>(context),
          builder: (context, state) {
            if (state is MarathonLoadingFailedByRunner) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else if (state is MarathonLoadedByRunner) {
              if (state.marathons.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Looks like you are yet to start your journey"),
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.marathons.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text(
                          "${state.marathons[index].title}",
                        ),
                        tileColor: Colors.blueGrey,
                        trailing: IconButton(
                          icon: Icon(FontAwesomeIcons.arrowAltCircleRight),
                          onPressed: () async {
                            AlertDialog alert(String title, {Widget display}) =>
                                AlertDialog(
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      display ?? CircularProgressIndicator(),
                                    ],
                                  ),
                                );
                            showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) {
                                return alert("Loading");
                              },
                            );
                            MarathonRepository repository =
                                injector.get<MarathonRepository>();
                            Either<Exception, Marathon> either =
                                await repository.fetchMarathonDetails(
                                    state.marathons[index].id,
                                    state.marathons[index].country);
                            either.fold((l) {
                              Navigator.of(context).pop();
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return alert("Error occured!",
                                      display: Icon(FontAwesomeIcons.cross));
                                },
                              );
                            }, (r) {
                              pushReplacementRoute(
                                context,
                                MarathonDetailScreen(
                                  marathon: r,
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
