import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'build_menu_item.dart';
import '../../Login/login_screen.dart';
import '../../Welcome/welcome_screen.dart';
import '../../../constants.dart';
import '../../../provider/google_sign_in.dart';

class NavigationDrawerWidget extends StatefulWidget {
  NavigationDrawerWidget({Key key}) : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: kProgressColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              const SizedBox(height: 48),
              Column(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage("assets/img/sloth.png"),
                  ),
                  const SizedBox(height: 24),
                  Text(loggedInUser.email,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white),
              const SizedBox(height: 24),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: kDecorationGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text("Tasks that are finished:",
                        style: const TextStyle(color: Colors.white)),
                    Text("$queryFinished",
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: kDecorationRed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text("Tasks that are not finished:",
                        style: const TextStyle(color: Colors.white)),
                    Text(
                      '$queryUnfinished',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white),
              const SizedBox(height: 24),
              buildMenuItem(
                text: 'About',
                icon: FontAwesomeIcons.infoCircle,
                function: () {
                  showAboutDialog(
                      context: context,
                      applicationVersion: '1.0.0',
                      applicationLegalese:
                          "This is a non-profit school project, illustrarions came from schoolmates, the list of dependencies that are in used are listed in the license view. \nThe information that the app recolets is the user's email and password, the application only saves the Task, Description and Date that user brings.");
                },
              ),
              const SizedBox(height: 18),
              buildMenuItem(
                text: 'Logout',
                icon: FontAwesomeIcons.signOutAlt,
                function: () => logoutUser(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logoutUser() {
    if (loggedInUser.providerData[0].providerId == 'password') {
      _auth.signOut().then((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(WelcomeScreen.routeName,
            ModalRoute.withName(LoginScreen.routeName));
      });
    } else {
      final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      provider.logout().then((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(WelcomeScreen.routeName,
            ModalRoute.withName(LoginScreen.routeName));
      });
    }
  }
}
