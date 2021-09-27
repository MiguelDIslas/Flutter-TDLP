import 'package:flutter/cupertino.dart';
import 'Screens/Dashboard/dashboard.dart';
import 'Screens/SignUp/sign_up_screen.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/RestorePassword/restore_password.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUp.routeName: (context) => SignUp(),
  DashboardScreen.routeName: (context) => DashboardScreen(),
  RestorePassword.routeName: (context) => RestorePassword(),
};
