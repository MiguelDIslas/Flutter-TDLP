import 'package:flutter/material.dart';

import 'legend_item.dart';
import '../../Tasks/components/to_do_list.dart';
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
    return Background(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: const Text('List of tasks 📝',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 35)),
              ),
              // Legend Start //
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LegendItems()),
              // Legend End //
              ToDoListStream(userID: loggedInUser.uid),
            ],
          ),
        ),
      ),
    );
  }
}
