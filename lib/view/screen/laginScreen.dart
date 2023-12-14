import 'package:flutter/material.dart';
import 'package:tic_tok/controller/authController.dart';
import 'package:tic_tok/view/screen/signUpScreen.dart';

import '../widget/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static Registrations registrations = Registrations();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        //const - Constant - Value - String , Int  - Fix Rahega  - Use Karna
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "TikTok Clone",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                myLabelText: "Email",
                myIcon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                myLabelText: "Password",
                myIcon: Icons.lock,
                toHide: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  registrations.loginUser(_emailController.text.trim(),
                      _passwordController.text.trim());
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: const Text("Login"))),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text("New User ? Click Here"))
          ],
        ),
      ),
    );
  }
}
