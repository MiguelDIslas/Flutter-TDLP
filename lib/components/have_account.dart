import 'package:flutter/material.dart';
import '../constants.dart';

class HaveAccount extends StatelessWidget {
  final String information;
  final Function onTap;
  final String text;

  const HaveAccount({Key key, this.information, this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(information,
              style: const TextStyle(color: kPrimaryColor, fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              text,
              style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
