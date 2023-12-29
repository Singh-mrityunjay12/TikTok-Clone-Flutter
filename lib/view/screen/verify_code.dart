import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tic_tok/controller/authController.dart';
import 'package:tic_tok/home_page1.dart';
import 'package:tic_tok/view/screen/HomeScreen.dart';
import 'package:tic_tok/view/widget/text_input.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verificationCodeController = TextEditingController();
  var controller = Get.put(Registrations());
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: verificationCodeController,
                decoration: InputDecoration(
                  hintText: "6 digit code",
                ),
              )),
          SizedBox(
            height: 20,
          ),
          loading == true
              ? CircularProgressIndicator()
              : Container(
                  margin: EdgeInsets.only(left: 55, right: 20),
                  height: 40,
                  width: MediaQuery.of(context).size.width - 20,
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        final credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: verificationCodeController.text.trim());

                        try {
                          await auth.signInWithCredential(credential);
                          Get.to(() => HomeScreen1());
                        } catch (e) {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: Container(child: const Text("Verify"))),
                )
        ],
      ),
    );
  }
}
