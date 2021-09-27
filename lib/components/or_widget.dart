import 'package:flutter/material.dart';
import '../constants.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildDivider(),
            Text(' Or ',
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: const Divider(
        color: kPrimaryColor,
        height: 1.5,
      ),
    );
  }
}
