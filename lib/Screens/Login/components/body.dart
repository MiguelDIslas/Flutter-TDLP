import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../RestorePassword/restore_password.dart';
import '../../SignUp/sign_up_screen.dart';
import '../../Dashboard/dashboard.dart';
import '../../../components/background_with_images.dart';
import '../../../components/rounded_button.dart';
import '../../../components/have_account.dart';
import '../../../components/forgot_password.dart';
// import '../../../components/or_widget.dart';
// import '../../../components/social_media.dart';
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
  bool showPassword = true;

  @override
  void initState() {
    super.initState();
    toast.init(context);
    _email.text = '';
    _password.text = '';
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
                      "Login",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 40),
                    ),
                  ],
                )),
            RoundedInputField(
              hintText: 'Write your email',
              obscureText: false,
              inputType: TextInputType.emailAddress,
              controller: _email,
            ),
            RoundedInputField(
              hintText: 'Write your password',
              obscureText: showPassword,
              icon: Icons.lock,
              suffixIcon: showPassword
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              controller: _password,
              functionShow: () {
                setState(() => showPassword = !showPassword);
              },
            ),
            ForgotPassword(
                onTap: () => Navigator.popAndPushNamed(
                    context, RestorePassword.routeName)),
            RoundedButton(
              text: 'Login',
              press: () async {
                setState(() => spinner = true);
                try {
                  if (_email.text == '' || _password.text == '') {
                    showBottomToast(' Please fill all fields', 2);
                    setState(() => spinner = false);
                    return false;
                  }
                  final bool isValidEmail =
                      EmailValidator.validate(_email.text);
                  if (!isValidEmail) {
                    showBottomToast(' Please enter a correct email', 2);
                    setState(() => spinner = false);
                    return false;
                  }
                  try {
                    final existinUser = await _auth.signInWithEmailAndPassword(
                        email: _email.text, password: _password.text);
                    if (existinUser != null) {
                      Navigator.pushNamed(context, DashboardScreen.routeName);
                    } else {
                      showBottomToast(
                          ' Error with your info\n User not found', 2);
                    }
                  } on FirebaseAuthException catch (e) {
                    showBottomToast(
                        ' Error with your info\n User not found', 2);
                    setState(() => spinner = false);
                    print(e);
                  }
                  setState(() => spinner = false);
                } on FormatException catch (e) {
                  print(e);
                }
              },
            ),
            HaveAccount(
              information: "Don't you have an account? ",
              text: 'Sign Up',
              onTap: () => Navigator.pushNamed(context, SignUp.routeName),
            ),
            // OrDivider(),
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
