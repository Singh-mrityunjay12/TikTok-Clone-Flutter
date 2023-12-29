import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tok/constant.dart';
import 'package:tic_tok/controller/authController.dart';
import 'package:tic_tok/view/screen/verify_code.dart';
import 'package:tic_tok/view/widget/text_input.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController = TextEditingController();
  var controller = Get.put(Registrations());
  bool loading = false;
  final auth = FirebaseAuth.instance;
  // Country selectedCountry = Country(
  //   phoneCode: "91",
  //   countryCode: "IN",
  //   e164Sc: 0,
  //   geographic: true,
  //   level: 1,
  //   name: "India",
  //   example: "India",
  //   displayName: "India",
  //   displayNameNoCountryCode: "IN",
  //   e164Key: "",
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with phone number"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple.shade50),
                  child: Image.asset("assets/image2.png"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Add your phone number.We will send you a verification number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 55,
                  // margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Login with phone no",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: borderColor,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: borderColor,
                        ),
                      ),
                      // prefixIcon: Container(
                      //   padding: const EdgeInsets.all(8.0),
                      //   margin: const EdgeInsets.all(8.0),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       showCountryPicker(
                      //           context: context,
                      //           countryListTheme: const CountryListThemeData(
                      //             bottomSheetHeight: 550,
                      //           ),
                      //           onSelect: (Country value) {
                      //             print(
                      //                 "///////////////////////////////////////////");
                      //             print(value.countryCode.toString());
                      //             setState(() {
                      //               selectedCountry = value;
                      //             });
                      //           });
                      //     },
                      //     child: Text(
                      //       "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                      //       style: TextStyle(
                      //           fontSize: 18,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                    ),
                    obscureText: false,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                loading == true
                    ? CircularProgressIndicator()
                    : Container(
                        // margin: EdgeInsets.only(left: 55, right: 45),
                        height: 40,
                        width: MediaQuery.of(context).size.width - 20,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                loading = true;
                              });
                              auth.verifyPhoneNumber(
                                  timeout: Duration(seconds: 50),
                                  phoneNumber:
                                      phoneNumberController.text.trim(),
                                  verificationCompleted:
                                      (PhoneAuthCredential) async {
                                    return;
                                  },
                                  verificationFailed: (e) async {
                                    //for error show
                                    Get.snackbar(
                                        "Error show message", e.toString());
                                    //if came exception so show this error
                                    setState(() {
                                      loading = false;
                                    });
                                  },
                                  codeSent:
                                      (String verification, int? token) async {
                                    Get.to(() => VerifyCodeScreen(
                                          verificationId: verification,
                                        ));
                                    setState(() {
                                      loading = false;
                                    });
                                  },
                                  codeAutoRetrievalTimeout: (e) {
                                    Get.snackbar(
                                        "Time Out Error", e.toString());
                                    setState(() {
                                      loading = false;
                                    });
                                    //if code a gaya time  out ho jaye to error show karane ke liye
                                  });
                            },
                            child: Container(child: const Text("Login"))),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
