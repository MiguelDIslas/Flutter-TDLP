import 'package:flutter/material.dart';

import '../../Login/login_screen.dart';
import '../../SignUp/sign_up_screen.dart';
import '../../../components/rounded_button.dart';

class NotLoggedUser extends StatelessWidget {
  const NotLoggedUser({Key key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RoundedButton(
          text: "Login",
          press: () => Navigator.pushNamed(context, LoginScreen.routeName),
        ),
        RoundedButton(
          text: "Sign Up",
          press: () => Navigator.pushNamed(context, SignUp.routeName),
        ),
      ],
    );
  }
}
