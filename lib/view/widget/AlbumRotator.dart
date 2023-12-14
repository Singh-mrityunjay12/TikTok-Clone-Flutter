import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AlbumRotatorScreen extends StatefulWidget {
  AlbumRotatorScreen({super.key, required this.profilePickUrl});
  String profilePickUrl;

  @override
  State<AlbumRotatorScreen> createState() => _AlbumRotatorScreenState();
}

class _AlbumRotatorScreenState extends State<AlbumRotatorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    controller.forward();
    controller.repeat();
  }

  //ab controller create kiya h to dispose bhi karege jisase memory jayada waist na ho

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: SizedBox(
        height: 70,
        width: 70,
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: const LinearGradient(
                      colors: [Colors.grey, Colors.white])),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                // child: const Image(
                //   fit: BoxFit.cover,
                //   image: NetworkImage(
                //       "https://www.koimoi.com/wp-content/new-galleries/2023/10/vikas-divyakirti-a-real-life-upsc-prof-to-play-himself-in-vikrant-massey-starrer-12th-fail-001.jpg"),
                // )
                child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.profilePickUrl)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
