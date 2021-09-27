import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'not_logged_user.dart';
import '../../Dashboard/dashboard.dart';
import '../../../components/background_with_images.dart';
import '../../../components/rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Welcome to TDLP",
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Hero(
              transitionOnUserGestures: true,
              tag: "index",
              child: Image.asset(
                "assets/img/index.png",
                height: size.height * 0.4,
              ),
            ),
          ),
          user != null
              ? RoundedButton(
                  text: "Let's Continue",
                  press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()),
                      ))
              : const NotLoggedUser()
        ],
      ),
    );
  }
}
