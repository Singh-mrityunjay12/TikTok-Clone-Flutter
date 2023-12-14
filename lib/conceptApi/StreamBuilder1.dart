import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilder1 extends StatefulWidget {
  const StreamBuilder1({Key? key}) : super(key: key);

  @override
  State<StreamBuilder1> createState() => _StreamBuilder1State();
}

class _StreamBuilder1State extends State<StreamBuilder1> {
  int counter = 0;
  StreamController<int> counterController =
      StreamController<int>(); // StreamController is a type of int
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: counterController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data.toString(),
                  style: const TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                );
              } else {
                return const Text(
                  "0",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                );
              }
            }), //StreamBuilder just like a suscriber
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter++;
          counterController.sink.add(counter);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
