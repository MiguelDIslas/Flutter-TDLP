import 'package:flutter/material.dart';
import '../constants.dart';

class ForgotPassword extends StatelessWidget {
  final Function onTap;

  const ForgotPassword({Key key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: onTap,
              child: const Text(
                'Forgot your password?',
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
