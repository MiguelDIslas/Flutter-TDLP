import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';

class LegendItems extends StatelessWidget {
  const LegendItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        rowIcon(
          text: "Progress",
          colors: kProgressColors,
          icon: FontAwesomeIcons.spinner,
        ),
        rowIcon(
          text: "Finished",
          colors: kFinishedColors,
          icon: Icons.check_circle,
        ),
        rowIcon(
          text: "Not finished",
          colors: kUnfinishedColors,
          icon: Icons.cancel,
        ),
      ],
    );
  }

  Widget rowIcon({
    @required String text,
    @required IconData icon,
    @required List<Color> colors,
  }) {
    return Row(
      children: <Widget>[
        Text("$text"),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: Colors.white),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ],
    );
  }
}
