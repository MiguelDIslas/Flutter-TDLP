import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'to_do_stream.dart';
import 'info_message.dart';
import '../../../constants.dart';
import '../../../components/background_app.dart';

class Body extends StatefulWidget {
  Body({Key key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final date = DateTime.now();
    final text = date.hour >= 5 && date.hour <= 11
        ? "Morning 🌕"
        : date.hour >= 12 && date.hour < 17
            ? "Afternoon 🌗"
            : "Evening 🌑";
    final dateFormat = DateFormat("yyyy-MM-dd").format(date);

    return Background(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Good $text',
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 35),
                ),
              ),
              const Text(
                "What is today's itinerary ?",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 6.5,
                    child: TextButton(
                        onPressed: () {
                          Alert(
                            context: context,
                            style: const AlertStyle(
                              descStyle: const TextStyle(fontSize: 14),
                            ),
                            type: AlertType.info,
                            content: InfoMessage(),
                          ).show();
                        },
                        child: const Icon(
                          Icons.info,
                          color: kPrimaryColor,
                        )),
                  ),
                  Container(
                      width: size.width / 2,
                      child: Text("$dateFormat",
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 15))),
                ],
              ),
              ToDoStream(userId: loggedInUser.uid),
            ],
          ),
        ),
      ),
    );
  }
}
