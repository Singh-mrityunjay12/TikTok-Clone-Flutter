import 'package:flutter/material.dart';

class SimpleAnimation1 extends StatefulWidget {
  const SimpleAnimation1({Key? key}) : super(key: key);

  @override
  State<SimpleAnimation1> createState() => _SimpleAnimation1State();
}

class _SimpleAnimation1State extends State<SimpleAnimation1>
    with TickerProviderStateMixin {
  late Animation<double> fadeAnimation;
  late AnimationController fadeAnimationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initilization
    fadeAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    fadeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(fadeAnimationController.view);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: fadeAnimation,
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    fadeAnimationController.forward();
                  },
                  child: const Text("show")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    fadeAnimationController.reverse();
                  },
                  child: const Text("hide"))
            ],
          ),
        ),
      ),
    ));
  }
}
