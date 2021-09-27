import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'to_do_stream.dart';
import 'legend_info.dart';
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
              Text(
                "$dateFormat",
                style: const TextStyle(fontSize: 15),
              ),
              ToDoStream(userId: loggedInUser.uid),
              LegendInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
