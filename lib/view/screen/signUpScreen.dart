import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tic_tok/controller/authController.dart';
import 'package:tic_tok/view/screen/laginScreen.dart';
import 'package:tic_tok/view/widget/text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static Registrations registrations = Get.put(Registrations());
  // static Registrations instance = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confermController = TextEditingController();
  final TextEditingController _UserController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            const Text(
              "Wellcome ToTik Tok ",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
            InkWell(
              onTap: () {
                // Registrations.instance.pickImage();
                registrations.pickImage();
              },
              child: Stack(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsjv8k9FpJH5AvquxbVyd06B5UludsXYeHuTLTGllucw&s"),
                    radius: 60,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.black,
                          )))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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
                myLabelText: "Set Password",
                myIcon: Icons.lock,
                toHide: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _confermController,
                myLabelText: "Confirm Password",
                myIcon: Icons.lock,
                toHide: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _UserController,
                myLabelText: "Username",
                myIcon: Icons.lock,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 33),
              child: ElevatedButton(
                  onPressed: () {
                    Registrations.instance.SignUp(
                        _UserController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        Registrations.instance.proimg);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width - 110,
                      margin: EdgeInsets.only(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(child: const Text("Sign Up")))),
            ),
            Row(
              children: [
                Expanded(child: Container()),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const LoginScreen());
                      },
                      child: Container(
                        height: 27,
                        width: 250,
                        margin: EdgeInsets.only(right: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,
                        ),
                        child: Center(
                            child: Text("Already have an account? Click")),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
