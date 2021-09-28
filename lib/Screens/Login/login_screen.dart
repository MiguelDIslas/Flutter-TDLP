import 'package:flutter/material.dart';
import 'components/body.dart';
//import 'package:todo_list_project/Screens/Dashboard/dashboard.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return Body();
  }
}

// class LoginScreen extends StatelessWidget {
//   static String routeName = "/login";
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: const CircularProgressIndicator());
//             } else if (snapshot.hasData) {
//               return DashboardScreen();
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: const Text('Something went wrong'),
//               );
//             } else {
//               return Body();
//             }
//           },
//         ),
//       );
// }
