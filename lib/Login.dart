import 'dart:async';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'SignUp.dart';
import 'extensions.dart';

class Screen {
  String email;
  String password;
  Screen(this.email, this.password);
}

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = '/Log';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEmailValid = false;

  void _validateEmail(String value) {
    setState(() {
      _isEmailValid = value.isValidEmail();
    });
  }

  void replaceWithHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  void replaceWithSignUp(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Welcome\nBack!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2023/09/22/15/45/panda-8269336_640.png",
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      suffixIcon: _isEmailValid
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _validateEmail,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      } else if (!value.isValidEmail()) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () {

                          replaceWithHome(context);

                      },
                      child: const Text(
                        'PROCEED',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Newbie?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            replaceWithSignUp(context);
                          },
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Screen? screen;
  bool showLoading = true;

  @override
  void initState() {
    super.initState();
    simulateLoading();
  }

  /*static void openScreen(BuildContext context,
      {Screen? screen, bool shouldReplace = false}) {
    if (shouldReplace) {
      Navigator.popAndPushNamed(context, Login.routeName, arguments: screen);
    } else {
      Navigator.pushNamed(context, Login.routeName, arguments: screen);
    }
  }
  */

  void simulateLoading() {
    setState(() {
      showLoading = true;
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        showLoading = false;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadArguments(context);
  }

  void loadArguments(BuildContext context) {
    screen = ModalRoute.of(context)!.settings.arguments as Screen?;
    if (screen != null) {
      _emailController.text = screen!.email;
      _passwordController.text = screen!.password;
    }
  }
}
