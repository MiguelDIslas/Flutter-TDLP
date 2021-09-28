import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

import '../../Login/login_screen.dart';
import '../../Dashboard/dashboard.dart';
import '../../../components/background_with_images.dart';
import '../../../components/rounded_button.dart';
import '../../../components/have_account.dart';
//import '../../../components/or_widget.dart';
//import '../../../components/social_media.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/customtoast.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool spinner = false;
  final toast = FToast();

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Hero(
                      transitionOnUserGestures: true,
                      tag: "index",
                      child: Image.asset(
                        "assets/img/index.png",
                        height: size.height * 0.1,
                      ),
                    ),
                    const Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 40),
                    ),
                  ],
                )),
            GestureDetector(
              child: Column(
                children: [
                  RoundedInputField(
                    hintText: 'Write an email',
                    obscureText: false,
                    onChanged: (value) {},
                    inputType: TextInputType.emailAddress,
                    controller: _email,
                  ),
                  RoundedInputField(
                    hintText: 'At least 6 characters',
                    obscureText: true,
                    icon: Icons.lock,
                    suffixIcon: Icons.remove_red_eye,
                    controller: _password,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            RoundedButton(
              text: 'Registration',
              press: () async {
                FocusScope.of(context).unfocus();
                try {
                  setState(() => spinner = true);
                  final bool isValidEmail =
                      EmailValidator.validate(_email.text);
                  if (!isValidEmail) {
                    showBottomToast(' Please enter a correct email', 2);
                    setState(() => spinner = false);
                    return false;
                  }
                  if (_password.text.length < 6) {
                    showBottomToast(' Password needs more than 6 chars', 2);
                    setState(() => spinner = false);
                    return false;
                  }
                  try {
                    await _auth.createUserWithEmailAndPassword(
                        email: _email.text.trim(),
                        password: _password.text.trim());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case "invalid-email":
                        showBottomToast(' Invalid email', 2);
                        setState(() => spinner = false);
                        break;
                      case "email-already-in-use":
                        showBottomToast(' Email already in use', 2);
                        setState(() => spinner = false);
                        break;
                    }
                  }

                  setState(() => spinner = false);
                } on FirebaseAuthException catch (e) {
                  print(e);
                }
              },
            ),
            HaveAccount(
              text: 'Sign In',
              information: 'Already have an account? ',
              onTap: () => Navigator.pushNamed(context, LoginScreen.routeName),
            ),
            //const OrDivider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[const SocialMediaSU()],
            // ),
          ],
        ),
      ),
    );
  }

  void showBottomToast(String message, int value) => toast.showToast(
      child: buildToast(message: message, value: value),
      gravity: ToastGravity.BOTTOM);
}
