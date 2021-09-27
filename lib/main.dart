import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'provider/google_sign_in.dart';
import 'provider/theme_provider.dart';
import 'Screens/Welcome/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TodoListProject());
}

class TodoListProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'TDLP',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          initialRoute: WelcomeScreen.routeName,
          routes: routes,
        ),
      );
}
