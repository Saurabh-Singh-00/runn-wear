import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runn_wear/models/marathon.dart';
import 'package:runn_wear/screens/widgets/participation_button.dart';
import 'package:wear/wear.dart';

class MarathonDetailScreen extends StatelessWidget {
  final Marathon marathon;

  const MarathonDetailScreen({Key key, this.marathon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              Flexible(
                  child: Text(
                "${marathon.title}",
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: ParticipateButton(
                  marathon: marathon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
