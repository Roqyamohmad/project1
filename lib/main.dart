import 'package:flutter/material.dart';
import 'Login.dart';
import 'SignUp.dart';
import 'Splash.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Splash(),
      initialRoute: Splash.routeName,
      routes: {
        Login.routeName: (context) => const Login(),
        SignUp.routeName: (context) => const SignUp(),
        Splash.routeName: (context) => const Splash(),
      },
    );
  }
}
