import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});
  static const routeName = '/Splash';

  @override
  Widget build(BuildContext context) {
    startSplashTimer(context);
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child:Column(
            children: [
              Spacer(),
          Container(
            width: 327,
            height: 274,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2023/09/22/15/45/panda-8269336_640.png",
                ),
              ),
            ),
          ),
          Spacer(), // Pushes the text further down
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              "Welcome",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        ),
      ),
    );
  }
  void startSplashTimer(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      navigateToNextScreen(context);
    });
  }
  void navigateToNextScreen(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
  }

}
