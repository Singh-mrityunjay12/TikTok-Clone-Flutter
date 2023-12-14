import 'dart:async';

import 'package:flutter/material.dart';

class BroadCostStream1 extends StatefulWidget {
  const BroadCostStream1({Key? key}) : super(key: key);

  @override
  State<BroadCostStream1> createState() => _BroadCostStream1State();
}

class _BroadCostStream1State extends State<BroadCostStream1> {
  int count = 0;
  int count1 = 0;
  StreamController controller = StreamController();
  StreamController controller1 = StreamController();
  late Stream myStream;
  late Stream myStream1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myStream = controller.stream.asBroadcastStream();
    myStream1 = controller1.stream.asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: myStream,
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
              }),
          StreamBuilder(
              stream: myStream1,
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
              }),
          ElevatedButton(
              onPressed: () {
                count1 = count1 + 3;
                controller1.sink.add(count1);
              },
              child: const Text("update"))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count++;
          controller.sink.add(count);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
