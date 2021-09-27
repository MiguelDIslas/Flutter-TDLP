import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

import '../../../components/background_with_images.dart';
import '../../../components/input_data.dart';
import '../../../components/rounded_button.dart';
import '../../../components/customtoast.dart';

TextEditingController _email = TextEditingController();
bool errorMail = false;
final toast = FToast();

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    toast.init(context);
    _email.clear();

    return Background(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: const Text('Restore my password',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 37,
                    )),
              ),
              SingleChildScrollView(
                child: GestureDetector(
                  child: Column(
                    children: <Widget>[
                      InputData(
                        label: 'Email',
                        hint: 'What is the email?',
                        disable: false,
                        controller: _email,
                        error: errorMail,
                        messageError: 'Task is necessary',
                      ),
                      RoundedButton(
                        text: 'Restore password',
                        press: () {
                          FocusScope.of(context).unfocus();
                          final bool isValidEmail =
                              EmailValidator.validate(_email.text);
                          if (!isValidEmail) {
                            showBottomToast(' Please enter a correct email', 2);
                            return false;
                          }
                          try {
                            _auth.sendPasswordResetEmail(
                                email: _email.text.trim());
                            _email.clear();
                            Navigator.pop(context);
                          } on FormatException catch (e) {
                            print(e);
                          }
                        },
                      ),
                      RoundedButton(
                        text: 'Back home',
                        press: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomToast(String message, int value) => toast.showToast(
      child: buildToast(message: message, value: value),
      gravity: ToastGravity.BOTTOM);
}
