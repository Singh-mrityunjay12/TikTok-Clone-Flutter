import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tok/ApiPracticeModel/apiModel2.dart';
import 'package:http/http.dart' as http;

class ApiConcept2 extends StatefulWidget {
  const ApiConcept2({Key? key}) : super(key: key);

  @override
  State<ApiConcept2> createState() => _ApiConcept2State();
}

class _ApiConcept2State extends State<ApiConcept2> {
  List<UserDetail> UserListData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData)

            ///yaha per phale chake karate h ki data hamara sahi se recieve hua h ki nahi
            {
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: UserListData.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(children: [
                          getText(
                              index, "ID ", UserListData[index].id.toString()),
                          getText(index, "Name ",
                              UserListData[index].name.toString()),
                          getText(index, "Email ",
                              UserListData[index].email.toString()),
                          getText(index, "Phone ",
                              UserListData[index].phone.toString()),
                          getText(index, "Website ",
                              UserListData[index].website.toString()),
                          getText(index, "Company Name ",
                              UserListData[index].company.toString()),
                          getText(index, "Address ",
                              '${UserListData[index].address.suite.toString()},${UserListData[index].address.street.toString()} ${UserListData[index].address.city.toString()}-${UserListData[index].address.zipcode.toString()}'),
                          getText(index, "Geo ",
                              UserListData[index].address.geo.lng.toString())
                        ]));
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Text getText(int index, String fieldName, String content) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: fieldName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      TextSpan(text: content, style: const TextStyle(fontSize: 16)),
      // TextSpan(text: "Jyoti"),
      // TextSpan(text: "Patel"),
      // TextSpan(text: "dta"),
    ]));
  }

  Future<List<UserDetail>> getData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body
        .toString()); //yaha data me ak list h jo hame response ke taur pe mila h
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        UserListData.add(UserDetail.fromJson(index));
      }
      return UserListData;
    } else {
      return UserListData; //yadi response.statusCode==200 nahi hua to ham empty list hi return kara denge
    }
  }
}
