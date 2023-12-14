import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tok/ApiPracticeModel/apiModel3.dart';

class Api3SerDeSe extends StatefulWidget {
  const Api3SerDeSe({Key? key}) : super(key: key);

  @override
  State<Api3SerDeSe> createState() => _Api3SerDeSeState();
}

class _Api3SerDeSeState extends State<Api3SerDeSe> {
  //object or instance of class
  UserModel userModel = UserModel(
      id: "0001",
      fulName: "Mrityunjay Singh",
      email: "singhmrityunjay511@gmail.com");
  //jason formate
  String userJson =
      '{"id":"0001","fullName":"Mrityunjay Singh","email":"singhmrityunjay511@gmail.com"}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  //Serialization
                  // object to map to json
                  Map<String, dynamic> userMap =
                      userModel.toMap(); //object to map
                  var json = jsonEncode(userMap); //map  to json
                  print(json);
                },
                child: const Text("Serialized")),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  //DeSerialization
                  //json to map to object //jsonDecode  string formate me leta h json value
                  var decode = jsonDecode(userJson);
                  print(decode);
                  Map<String, dynamic> userMap = decode;
                  UserModel newUser = UserModel.fromMap(userMap);
                  print("///////////////////////////////////");
                  print(newUser);
                },
                child: const Text("DeSerialized")),
          ],
        ),
      ),
    );
  }
}
