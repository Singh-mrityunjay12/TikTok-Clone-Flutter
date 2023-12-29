import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tok/ApiPracticeModel/apiModel.dart';
import 'package:http/http.dart' as http;

class ApiConceopt extends StatefulWidget {
  const ApiConceopt({Key? key}) : super(key: key);

  @override
  State<ApiConceopt> createState() => _ApiConceoptState();
}

class _ApiConceoptState extends State<ApiConceopt> {
  List<Name> sampleData = [];
  @override
  Widget build(BuildContext context) {
    //FutureBuilder ka use ham isiliye karate h ki data server se ane thoda time lagata h to isiliye use karate jab tak data nahi ata tab tak ham CircularProgressIdicator() chalate h else part me
    //FutureBuilder ak required function hota h jise ham future kahate h jisame ham us function ko call karate h jisaka use karake data fetch karate h
    //builder:(contex,snapshot)  ismae jo snapshot h isaka use karake ham pata karate h data aya ki nahi server se
    return Scaffold(
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: sampleData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        color: Colors.teal,
                        height: 150,
                        child: Column(
                          children: [
                            Text("asxdcfghjkl. ${sampleData[index].userId}"),
                            Text("asxdcfghjkl. ${sampleData[index].id}"),
                            Text("asxdcfghjkl. ${sampleData[index].title}"),
                            Text(
                              maxLines: 1,
                              "asxdcfghjkl. ${sampleData[index].body}",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Future<List<Name>> getData() async {
    final responce =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        sampleData.add(Name.fromJson(index)); //or fromMap
      }
      return sampleData;
    } else {
      return sampleData;
    }
  }
}
